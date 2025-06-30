import 'package:comparador_de_precos/features/auth/signup/bloc/file_picker_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UploadDocumentsSection extends StatelessWidget {
  const UploadDocumentsSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilePickerBloc, FilePickerState>(
      builder: (context, state) {
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Anexar Documentos',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ElevatedButton.icon(
                      icon: const Icon(Icons.attach_file),
                      label: const Text('Anexar arquivos'),
                      onPressed: state.files.length >= 5
                          ? null
                          : () => context
                              .read<FilePickerBloc>()
                              .add(PickFilesEvent()),
                    ),
                    const SizedBox(width: 8),
                    const Text('Máx. 5 arquivos, até 1MB cada'),
                  ],
                ),
                const SizedBox(height: 8),
                if (state.files.isNotEmpty)
                  Wrap(
                    spacing: 8,
                    children: List.generate(state.files.length, (i) {
                      final file = state.files[i];
                      return Chip(
                        label: Text(file.name),
                        onDeleted: () => context
                            .read<FilePickerBloc>()
                            .add(RemoveFileEvent(i)),
                      );
                    }),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
