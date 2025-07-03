import 'package:flutter/material.dart';
import 'package:comparador_de_precos/features/admin/admin_solicitacoes_lojas/bloc/bloc.dart';

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
    return BlocBuilder<AdminSolicitacoesLojasBloc, AdminSolicitacoesLojasState>(
      builder: (context, state) {
        return Center(child: Text(state.customProperty));
      },
    );
  }
}
