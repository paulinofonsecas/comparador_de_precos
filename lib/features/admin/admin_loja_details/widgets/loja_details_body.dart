import 'package:comparador_de_precos/data/models/loja.dart';
import 'package:comparador_de_precos/features/admin/admin_loja_details/cubit/aprovar_loja_cubit.dart';
import 'package:comparador_de_precos/features/admin/admin_loja_details/cubit/desaprovar_loja_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LojaDetailsBody extends StatelessWidget {
  const LojaDetailsBody({
    required this.loja,
    super.key,
  });

  final Loja loja;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final imageHeight = mediaQuery.size.height * 0.25;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              height: imageHeight,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: loja.logoUrl != null && loja.logoUrl!.isNotEmpty
                    ? Image.network(
                        loja.logoUrl!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          color: Colors.grey[200],
                          child: const Icon(Icons.store, size: 56),
                        ),
                      )
                    : Container(
                        color: Colors.grey[200],
                        child: const Icon(Icons.store, size: 56),
                      ),
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Text(
                loja.nome,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            const SizedBox(height: 8),
            if (loja.endereco != null)
              Row(
                children: [
                  Icon(Icons.location_on, size: 18, color: Colors.grey[700]),
                  const SizedBox(width: 4),
                  Expanded(child: Text(loja.endereco!)),
                ],
              ),
            const SizedBox(height: 8),
            if (loja.telefoneContato != null)
              Row(
                children: [
                  Icon(Icons.phone, size: 18, color: Colors.grey[700]),
                  const SizedBox(width: 4),
                  Text(loja.telefoneContato!),
                ],
              ),
            const SizedBox(height: 8),
            if (loja.descricao != null)
              Text(
                loja.descricao!,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Icon(Icons.star, color: Colors.amber, size: 20),
                const SizedBox(width: 4),
                Text(loja.classificacaoMedia.toStringAsFixed(1)),
                const SizedBox(width: 8),
                Text('(${loja.numeroAvaliacoes} avaliações)'),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(),
            Text(
              'Administração',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ElevatedButton.icon(
                  icon: Icon(
                    Icons.verified_user,
                    color: loja.aprovada ?? false
                        ? Theme.of(context).colorScheme.onErrorContainer
                        : Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                  label: Text(
                    loja.aprovada ?? false ? 'Desaprovar Loja' : 'Aprovar Loja',
                    style: TextStyle(
                      color: loja.aprovada ?? false
                          ? Theme.of(context).colorScheme.onErrorContainer
                          : Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: loja.aprovada ?? false
                        ? Theme.of(context).colorScheme.errorContainer
                        : Theme.of(context).colorScheme.primaryContainer,
                    foregroundColor:
                        loja.aprovada ?? false ? Colors.white : Colors.white,
                  ),
                  onPressed: () {
                    if (loja.aprovada ?? false) {
                      context
                          .read<DesaprovarLojaCubit>()
                          .desaprovarLoja(loja.id);
                    } else {
                      context.read<AprovarLojaCubit>().aprovarLoja(loja.id);
                    }
                  },
                ),
                ElevatedButton.icon(
                  icon: const Icon(Icons.person),
                  label: const Text('Alterar Usuário'),
                  onPressed: () {
                    // TODO: Implementar ação de alterar usuário
                  },
                ),
                ElevatedButton.icon(
                  icon: const Icon(Icons.edit),
                  label: const Text('Editar Loja'),
                  onPressed: () {
                    // TODO: Implementar ação de editar loja
                  },
                ),
                ElevatedButton.icon(
                  icon: const Icon(Icons.delete),
                  label: const Text('Excluir Loja'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.error,
                    foregroundColor: Theme.of(context).colorScheme.onError,
                  ),
                  onPressed: () {
                    // TODO: Implementar ação de excluir loja
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              'Criada em: ${loja.createdAt.toLocal().toString().split(' ')[0]}',
            ),
            Text(
              'Atualizada em: ${loja.updatedAt.toLocal().toString().split(' ')[0]}',
            ),
          ],
        ),
      ),
    );
  }
}
