import 'package:comparador_de_precos/data/models/solicitacao_loja.dart';
import 'package:comparador_de_precos/features/admin/admin_dashboard/bloc/bloc.dart';
import 'package:comparador_de_precos/features/admin/admin_solicitacoes_lojas/cubit/get_solicitacoes_loja_cubit.dart';
import 'package:comparador_de_precos/features/admin/admin_solicitacoes_lojas/widgets/custom_solicitacao_card.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';

/// {@template admin_solicitacoes_lojas_body}
/// Body of the AdminSolicitacoesLojasPage.
///
/// Add what it does
/// {@endtemplate}
class AdminSolicitacoesLojasBody extends StatelessWidget {
  /// {@macro admin_solicitacoes_lojas_body}
  const AdminSolicitacoesLojasBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetSolicitacoesLojaCubit, GetSolicitacoesLojaState>(
      builder: (context, state) {
        if (state is GetSolicitacoesLojaInitial) {
          context.read<GetSolicitacoesLojaCubit>().getSolicitacoes();
          return const Center(child: CircularProgressIndicator());
        }

        if (state is GetSolicitacoesLojaLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is GetSolicitacoesLojaError) {
          return const Center(
            child: Text('Erro: Ocorreu um erro ao carregar as solicitações.'),
          );
        }

        final solicitacoes = (state as GetSolicitacoesLojaLoaded).solicitacoes;

        return ListView.builder(
          itemCount: solicitacoes.length,
          itemBuilder: (context, index) {
            final faker = Faker();
            final solicitacao = solicitacoes[index];

            return CustomSolicitacaoCard(solicitacao: solicitacao);
          },
        );
      },
    );
  }
}
