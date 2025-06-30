import 'package:flutter/material.dart';

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
              ' da loja serão usados para contato e verificação.',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _usuarioNomeController,
              decoration: const InputDecoration(labelText: 'Nome Completo *'),
              validator: (v) => v == null || v.trim().isEmpty
                  ? 'Informe seu nome completo'
                  : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _usuarioEmailController,
              decoration: const InputDecoration(labelText: 'E-mail *'),
              keyboardType: TextInputType.emailAddress,
              validator: (v) =>
                  v == null || v.trim().isEmpty ? 'Informe seu e-mail' : null,
            ),
          ],
        ),
      ),
    );
  }
}