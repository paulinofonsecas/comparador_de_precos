import 'package:comparador_de_precos/features/logista/solicitar_cadastro/bloc/bloc.dart';
import 'package:flutter/material.dart';

/// {@template solicitar_cadastro_body}
/// Body of the SolicitarCadastroPage.
///
/// Add what it does
/// {@endtemplate}
class SolicitarCadastroBody extends StatelessWidget {
  /// {@macro solicitar_cadastro_body}
  const SolicitarCadastroBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SolicitarCadastroBloc, SolicitarCadastroState>(
      builder: (context, state) {
        return Center(child: Text(state.customProperty));
      },
    );
  }
}
