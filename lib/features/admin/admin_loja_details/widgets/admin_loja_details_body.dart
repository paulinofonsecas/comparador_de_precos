import 'dart:developer';

import 'package:comparador_de_precos/features/admin/admin_loja_details/bloc/bloc.dart';
import 'package:comparador_de_precos/features/admin/admin_loja_details/widgets/loja_details_body.dart';
import 'package:flutter/material.dart';

/// {@template admin_loja_details_body}
/// Body of the AdminLojaDetailsPage.
///
/// Add what it does
/// {@endtemplate}
class AdminLojaDetailsBody extends StatelessWidget {
  /// {@macro admin_loja_details_body}
  const AdminLojaDetailsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdminLojaDetailsBloc, AdminLojaDetailsState>(
      builder: (context, state) {
        if (state is AdminLojaDetailsLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is AdminLojaDetailsError) {
          log('Erro ao carregar detalhes da loja: ${state.message}');

          return const Center(
            child: Text('Ocorreu um erro ao carregar os detalhes da loja'),
          );
        } else if (state is AdminLojaDetailsLoaded) {
          final loja = state.loja;

          return LojaDetailsBody(loja: loja);
        }
        return const SizedBox.shrink();
      },
    );
  }
}
