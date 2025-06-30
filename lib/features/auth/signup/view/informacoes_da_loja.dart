import 'package:flutter/material.dart';

class InformacoesDaLoja extends StatelessWidget {
  const InformacoesDaLoja({
    required TextEditingController nomeController,
    required TextEditingController enderecoController,
    required TextEditingController telefoneController,
    required TextEditingController descricaoController,
    required TextEditingController latitudeController,
    required TextEditingController longitudeController,
    super.key,
  })  : _nomeController = nomeController,
        _enderecoController = enderecoController,
        _telefoneController = telefoneController,
        _descricaoController = descricaoController,
        _latitudeController = latitudeController,
        _longitudeController = longitudeController;

  final TextEditingController _nomeController;
  final TextEditingController _enderecoController;
  final TextEditingController _telefoneController;
  final TextEditingController _descricaoController;
  final TextEditingController _latitudeController;
  final TextEditingController _longitudeController;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Informações da Loja',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
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
          ],
        ),
      ),
    );
  }
}