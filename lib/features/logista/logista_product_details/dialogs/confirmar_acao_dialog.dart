import 'package:flutter/material.dart';

class ConfirmarAcaoDialog extends StatelessWidget {
  const ConfirmarAcaoDialog({
    super.key,
  });

  static Future<bool?> show(
    BuildContext context,
  ) async {
    return showDialog<bool>(
      context: context,
      builder: (c) => const ConfirmarAcaoDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Confirmar operação'),
      content: const Text('Tem a certeza que deseja confirar esta ação?'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          child: const Text('Cancelar'),
        ),
        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: Theme.of(context).colorScheme.error,
          ),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
          child: const Text('Confirmar'),
        ),
      ],
    );
  }
}
