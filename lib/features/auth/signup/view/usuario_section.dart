import 'package:comparador_de_precos/app/config/dependencies.dart';
import 'package:comparador_de_precos/data/models/my_user.dart';
import 'package:comparador_de_precos/data/models/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class UsuarioSection extends StatelessWidget {
  const UsuarioSection({
    super.key,
    required TextEditingController usuarioNomeController,
    required TextEditingController usuarioEmailController,
  })  : _usuarioNomeController = usuarioNomeController,
        _usuarioEmailController = usuarioEmailController;

  final TextEditingController _usuarioNomeController;
  final TextEditingController _usuarioEmailController;

  @override
  Widget build(BuildContext context) {
    final profile = getIt<UserProfile>();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Dados do Usuário',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Os dados do usuário que está solicitando o cadastro'
              ' da loja serão usados para contrato e verificação inclusive os dados de sessão.',
              style: TextStyle(fontSize: 14, color: Colors.black),
            ),
            const SizedBox(height: 16),
            Text('Nome: ${profile.nomeCompleto}'),
            const SizedBox(height: 8),
            Text('Email: ${profile.bi}'),
          ],
        ),
      ),
    );
  }
}
