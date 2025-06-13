import 'dart:async';
import 'dart:developer';

import 'package:comparador_de_precos/data/models/loja.dart';
import 'package:flutter/material.dart';
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
  bool _isLoading = false;

  Future<void> _enviarSolicitacao() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    
    final loja = Loja(
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
      aprovada: false,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    try {
      log(loja.toJson().toString());
      await Supabase.instance.client.from('lojas').insert(loja.toJson());

      setState(() => _isLoading = false);

      unawaited(
        showDialog(
          // ignore: use_build_context_synchronously
          context: context,
          builder: (_) => AlertDialog(
            title: const Text('Solicitação enviada'),
            content: Text("Sua solicitação de cadastro da loja '${loja.nome}'"
                ' foi enviada e será analisada em breve.'),
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
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao enviar solicitação: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Solicitar Cadastro de Loja')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nomeController,
                decoration: const InputDecoration(labelText: 'Nome da Loja *'),
                validator: (v) => v == null || v.trim().isEmpty
                    ? 'Informe o nome da loja'
                    : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _enderecoController,
                decoration:
                    const InputDecoration(labelText: 'Endereço Completo *'),
                validator: (v) =>
                    v == null || v.trim().isEmpty ? 'Informe o endereço' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _telefoneController,
                decoration:
                    const InputDecoration(labelText: 'Telefone de Contato'),
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descricaoController,
                decoration: const InputDecoration(labelText: 'Descrição Curta'),
                maxLines: 2,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _latitudeController,
                decoration:
                    const InputDecoration(labelText: 'Latitude (opcional)'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _longitudeController,
                decoration:
                    const InputDecoration(labelText: 'Longitude (opcional)'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 24),
              if (_isLoading)
                const Center(child: CircularProgressIndicator())
              else
                ElevatedButton(
                  onPressed: _enviarSolicitacao,
                  child: const Text('Enviar Solicitação de Cadastro'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
