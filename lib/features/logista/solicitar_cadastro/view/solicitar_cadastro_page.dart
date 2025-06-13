import 'package:flutter/material.dart';
import 'package:comparador_de_precos/features/logista/solicitar_cadastro/bloc/bloc.dart';
import 'package:comparador_de_precos/features/logista/solicitar_cadastro/widgets/solicitar_cadastro_body.dart';

/// {@template solicitar_cadastro_page}
/// A description for SolicitarCadastroPage
/// {@endtemplate}
class SolicitarCadastroPage extends StatelessWidget {
  /// {@macro solicitar_cadastro_page}
  const SolicitarCadastroPage({super.key});

  /// The static route for SolicitarCadastroPage
  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(builder: (_) => const SolicitarCadastroPage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SolicitarCadastroBloc(),
      child: const Scaffold(
        body: SolicitarCadastroView(),
      ),
    );
  }    
}

/// {@template solicitar_cadastro_view}
/// Displays the Body of SolicitarCadastroView
/// {@endtemplate}
class SolicitarCadastroView extends StatelessWidget {
  /// {@macro solicitar_cadastro_view}
  const SolicitarCadastroView({super.key});

  @override
  Widget build(BuildContext context) {
    return const SolicitarCadastroBody();
  }
}
