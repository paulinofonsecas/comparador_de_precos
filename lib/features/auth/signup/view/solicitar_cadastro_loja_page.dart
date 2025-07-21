import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:comparador_de_precos/app/config/dependencies.dart';
import 'package:comparador_de_precos/data/models/solicitacao_loja.dart';
import 'package:comparador_de_precos/data/models/user_profile.dart';
import 'package:comparador_de_precos/features/auth/signup/bloc/file_picker_bloc.dart';
import 'package:comparador_de_precos/features/auth/signup/view/informacoes_da_loja.dart';
import 'package:comparador_de_precos/features/auth/signup/view/upload_documents_section.dart';
import 'package:comparador_de_precos/features/auth/signup/view/usuario_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

class SolicitarCadastroLojaPage extends StatefulWidget {
  const SolicitarCadastroLojaPage({super.key});

  @override
  State<SolicitarCadastroLojaPage> createState() =>
      _SolicitarCadastroLojaPageState();
}

class _SolicitarCadastroLojaPageState extends State<SolicitarCadastroLojaPage> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _enderecoController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _descricaoController = TextEditingController();
  final _latitudeController = TextEditingController();
  final _longitudeController = TextEditingController();

  // user information is not used in this page, but can be added if needed
  final _usuarioNomeController = TextEditingController();
  final _usuarioEmailController = TextEditingController();

  bool _isLoading = false;

  Future<void> _enviarSolicitacao(List<File> files) async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    final userProfile = getIt<UserProfile>();

    final solicitacaoLoja = SolicitacaoLoja(
      id: const Uuid().v4(),
      nome: _nomeController.text.trim(),
      endereco: _enderecoController.text.trim(),
      telefoneContato: _telefoneController.text.trim().isEmpty
          ? null
          : _telefoneController.text.trim(),
      descricao: _descricaoController.text.trim().isEmpty
          ? null
          : _descricaoController.text.trim(),
      latitude: _latitudeController.text.trim().isEmpty
          ? null
          : double.tryParse(_latitudeController.text.trim()),
      longitude: _longitudeController.text.trim().isEmpty
          ? null
          : double.tryParse(_longitudeController.text.trim()),
      userProfileId: userProfile.id,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    try {
      log(solicitacaoLoja.toJson().toString());
      final idResponse = await Supabase.instance.client
          .from('solicitacoes_lojas')
          .insert(solicitacaoLoja.toMap())
          .select('id');

      final lojaId = idResponse[0]['id'] as String;
      log('Loja cadastrada com ID: $lojaId');

      // Upload files to Supabase storage
      final storage =
          Supabase.instance.client.storage.from('solicitacoes-lojas');

      for (final file in files) {
        await storage.upload(
          file.path.split('/').last, // Use the file name as the path
          file,
          fileOptions: const FileOptions(
            contentType: 'application/pdf',
          ),
        );
        log('Arquivo enviado: ${file.path}');

        await Supabase.instance.client
            .from('documentos_solicitacoes_lojas')
            .insert({
          'solicitacao_loja_id': lojaId,
          'file_path': storage.getPublicUrl(file.path),
        });
      }

      setState(() => _isLoading = false);

      unawaited(
        showDialog(
          // ignore: use_build_context_synchronously
          context: context,
          builder: (_) => AlertDialog(
            title: const Text('Solicitação enviada'),
            content: Column(
              children: [
                Text(
                    "Sua solicitação de cadastro da loja '${solicitacaoLoja.nome}'"
                    ' foi enviada e será analisada em breve.'),
                const Icon(Icons.verified, color: Colors.green),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () =>
                    Navigator.of(context).popUntil((route) => route.isFirst),
                child: const Text('OK'),
              ),
            ],
          ),
        ),
      );
    } catch (e) {
      setState(() => _isLoading = false);
      log(e.toString());
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erro ao enviar solicitação')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Solicitar Cadastro de Loja')),
      body: Theme(
        data: Theme.of(context).copyWith(
          inputDecorationTheme: const InputDecorationTheme(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
          ),
        ),
        child: BlocProvider(
          create: (_) => FilePickerBloc(),
          child: Builder(
            builder: (context) {
              return Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: ListView(
                    children: [
                      InformacoesDaLoja(
                        nomeController: _nomeController,
                        enderecoController: _enderecoController,
                        telefoneController: _telefoneController,
                        descricaoController: _descricaoController,
                        latitudeController: _latitudeController,
                        longitudeController: _longitudeController,
                      ),
                      const Gutter(),
                      UsuarioSection(
                        usuarioNomeController: _usuarioNomeController,
                        usuarioEmailController: _usuarioEmailController,
                      ),
                      const Gutter(),
                      const UploadDocumentsSection(),
                      const Gutter(),
                      if (_isLoading)
                        const Center(child: CircularProgressIndicator())
                      else
                        ElevatedButton(
                          onPressed: () {
                            if (!_formKey.currentState!.validate()) return;

                            // Check if files are selected
                            final files =
                                context.read<FilePickerBloc>().state.files;

                            if (files.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Nenhum arquivo anexado'),
                                ),
                              );
                              return;
                            }

                            _enviarSolicitacao(
                              files.map((file) => File(file.path!)).toList(),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text('Enviar Solicitação de Cadastro'),
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
