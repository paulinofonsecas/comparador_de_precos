import 'package:flutter/material.dart';
import 'package:comparador_de_precos/features/admin/admin_gestao_lojas/bloc/bloc.dart';

/// {@template admin_gestao_lojas_body}
/// Body of the AdminGestaoLojasPage.
///
/// Add what it does
/// {@endtemplate}
class AdminGestaoLojasBody extends StatelessWidget {
  /// {@macro admin_gestao_lojas_body}
  const AdminGestaoLojasBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdminGestaoLojasBloc, AdminGestaoLojasState>(
      builder: (context, state) {
        return Center(child: Text(state.customProperty));
      },
    );
  }
}
