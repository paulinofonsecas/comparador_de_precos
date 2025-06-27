import 'package:comparador_de_precos/app/config/dependencies.dart';
import 'package:comparador_de_precos/features/admin/admin_gestao_lojas/bloc/bloc.dart';
import 'package:comparador_de_precos/features/admin/admin_gestao_lojas/cubit/admin_get_lojas_cubit.dart';
import 'package:comparador_de_precos/features/admin/admin_gestao_lojas/cubit/search_lojas_cubit.dart';
import 'package:comparador_de_precos/features/admin/admin_gestao_lojas/widgets/admin_gestao_lojas_body.dart';
import 'package:flutter/material.dart';

/// {@template admin_gestao_lojas_page}
/// A description for AdminGestaoLojasPage
/// {@endtemplate}
class AdminGestaoLojasPage extends StatelessWidget {
  /// {@macro admin_gestao_lojas_page}
  const AdminGestaoLojasPage({super.key});

  /// The static route for AdminGestaoLojasPage
  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(
        builder: (_) => const AdminGestaoLojasPage());
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AdminGestaoLojasBloc(),
        ),
        BlocProvider(
          create: (context) => SearchLojasCubit(getIt()),
        ),
        BlocProvider(
          create: (context) => AdminGetLojasCubit(getIt())..fetchLojas(),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Gestão de Lojas'),
        ),
        body: const AdminGestaoLojasView(),
      ),
    );
  }
}

/// {@template admin_gestao_lojas_view}
/// Displays the Body of AdminGestaoLojasView
/// {@endtemplate}
class AdminGestaoLojasView extends StatelessWidget {
  /// {@macro admin_gestao_lojas_view}
  const AdminGestaoLojasView({super.key});

  @override
  Widget build(BuildContext context) {
    return const AdminGestaoLojasBody();
  }
}
