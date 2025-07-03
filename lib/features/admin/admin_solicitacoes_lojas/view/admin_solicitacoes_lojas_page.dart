import 'package:comparador_de_precos/app/config/dependencies.dart';
import 'package:comparador_de_precos/features/admin/admin_solicitacoes_lojas/bloc/bloc.dart';
import 'package:comparador_de_precos/features/admin/admin_solicitacoes_lojas/cubit/get_solicitacoes_loja_cubit.dart';
import 'package:comparador_de_precos/features/admin/admin_solicitacoes_lojas/widgets/admin_solicitacoes_lojas_body.dart';
import 'package:flutter/material.dart';

/// {@template admin_solicitacoes_lojas_page}
/// A description for AdminSolicitacoesLojasPage
/// {@endtemplate}
class AdminSolicitacoesLojasPage extends StatelessWidget {
  /// {@macro admin_solicitacoes_lojas_page}
  const AdminSolicitacoesLojasPage({super.key});

  /// The static route for AdminSolicitacoesLojasPage
  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(
      builder: (_) => const AdminSolicitacoesLojasPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AdminSolicitacoesLojasBloc(),
        ),
        BlocProvider(
          create: (context) => GetSolicitacoesLojaCubit(getIt()),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Solicitações de lojas'),
        ),
        body: const AdminSolicitacoesLojasView(),
      ),
    );
  }
}

/// {@template admin_solicitacoes_lojas_view}
/// Displays the Body of AdminSolicitacoesLojasView
/// {@endtemplate}
class AdminSolicitacoesLojasView extends StatelessWidget {
  /// {@macro admin_solicitacoes_lojas_view}
  const AdminSolicitacoesLojasView({super.key});

  @override
  Widget build(BuildContext context) {
    return const AdminSolicitacoesLojasBody();
  }
}
