import 'dart:developer';

import 'package:comparador_de_precos/data/models/loja.dart';
import 'package:comparador_de_precos/data/models/user_profile.dart';
import 'package:comparador_de_precos/features/admin/admin_loja_details/bloc/admin_loja_details_bloc.dart';
import 'package:comparador_de_precos/features/admin/admin_loja_details/cubit/aprovar_loja_cubit.dart';
import 'package:comparador_de_precos/features/admin/admin_loja_details/cubit/desaprovar_loja_cubit.dart';
import 'package:comparador_de_precos/features/admin/admin_loja_details/cubit/get_lojistas_cubit.dart';
import 'package:comparador_de_precos/widgets/default_search_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdministracaoSection extends StatelessWidget {
  const AdministracaoSection({
    required this.loja,
    super.key,
  });

  final Loja loja;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
              icon: const Icon(Icons.person),
              label: const Text('Alterar Usuário'),
              onPressed: () async {
                final resultado =
                    await DefaultSearchBottomSheet.show<UserProfile>(
                  context: context,
                  asyncLoader: (search) async {
                    final lojistas = await context
                        .read<GetLojistasCubit>()
                        .getLojistas(search);

                    return lojistas.toList();
                  },
                  itemToString: (item) => item.nomeCompleto ?? 'Sem Nome',
                  itemSubtitle: (item) => 'Subtítulo de ${item.nomeCompleto}',
                  title: 'Selecione um Lojista',
                );

                if (resultado == null) {
                  log('Nenhum lojista selecionado');
                  return;
                }

                // ignore: use_build_context_synchronously
                context.read<AdminLojaDetailsBloc>().add(
                      AdminLojaDetailsAlterarLojistaEvent(
                        lojaId: loja.id,
                        novoLojistaId: resultado.id,
                      ),
                    );
              },
            ),
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
                  context.read<DesaprovarLojaCubit>().desaprovarLoja(loja.id);
                } else {
                  context.read<AprovarLojaCubit>().aprovarLoja(loja.id);
                }
              },
            ),
            ElevatedButton.icon(
              icon: const Icon(Icons.delete),
              label: const Text('Excluir Loja'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.error,
                foregroundColor: Theme.of(context).colorScheme.onError,
              ),
              onPressed: null,
            ),
          ],
        ),
      ],
    );
  }
}
