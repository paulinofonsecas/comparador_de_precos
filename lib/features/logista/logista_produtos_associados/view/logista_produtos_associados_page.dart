import 'package:comparador_de_precos/app/config/dependencies.dart';
import 'package:comparador_de_precos/features/logista/logista_produtos_associados/cubit/get_produtos_associados_cubit.dart';
import 'package:flutter/material.dart';
import 'package:comparador_de_precos/features/logista/logista_produtos_associados/bloc/bloc.dart';
import 'package:comparador_de_precos/features/logista/logista_produtos_associados/widgets/logista_produtos_associados_body.dart';

/// {@template logista_produtos_associados_page}
/// A description for LogistaProdutosAssociadosPage
/// {@endtemplate}
class LogistaProdutosAssociadosPage extends StatelessWidget {
  /// {@macro logista_produtos_associados_page}
  const LogistaProdutosAssociadosPage({super.key});

  /// The static route for LogistaProdutosAssociadosPage
  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(
        builder: (_) => const LogistaProdutosAssociadosPage());
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LogistaProdutosAssociadosBloc(),
        ),
        BlocProvider(
          create: (context) => GetProdutosAssociadosCubit(getIt()),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('LogistaProdutosAssociadosPage'),
        ),
        body: const LogistaProdutosAssociadosView(),
      ),
    );
  }
}

/// {@template logista_produtos_associados_view}
/// Displays the Body of LogistaProdutosAssociadosView
/// {@endtemplate}
class LogistaProdutosAssociadosView extends StatelessWidget {
  /// {@macro logista_produtos_associados_view}
  const LogistaProdutosAssociadosView({super.key});

  @override
  Widget build(BuildContext context) {
    return const LogistaProdutosAssociadosBody();
  }
}
