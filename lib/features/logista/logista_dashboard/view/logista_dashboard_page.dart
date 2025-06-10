import 'package:comparador_de_precos/app/config/dependencies.dart';
import 'package:comparador_de_precos/data/models/my_user.dart';
import 'package:comparador_de_precos/features/auth/signin/cubit/login_cubit.dart';
import 'package:comparador_de_precos/features/auth/signin/view/signin_page.dart';
import 'package:comparador_de_precos/features/logista/logista_dashboard/bloc/bloc.dart';
import 'package:comparador_de_precos/features/logista/logista_dashboard/cubit/get_logista_profile_cubit.dart';
import 'package:comparador_de_precos/features/logista/logista_dashboard/widgets/logista_dashboard_body.dart';
import 'package:flutter/material.dart';

/// {@template logista_dashboard_page}
/// A description for LogistaDashboardPage
/// {@endtemplate}
class LogistaDashboardPage extends StatelessWidget {
  /// {@macro logista_dashboard_page}
  const LogistaDashboardPage({required this.user, super.key});

  final MyUser user;

  /// The static route for LogistaDashboardPage
  static Route<dynamic> route({required MyUser user}) {
    return MaterialPageRoute<dynamic>(
      builder: (_) => LogistaDashboardPage(
        user: user,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LogistaDashboardBloc(),
        ),
        BlocProvider(
          create: (context) =>
              GetLogistaProfileCubit(getIt())..getLogistaProfile(user.id),
        ),
        BlocProvider(
          create: (context) => LoginCubit(getIt()),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Painel do lojista'),
        ),
        body: const LogistaDashboardView(),
      ),
    );
  }
}

/// {@template logista_dashboard_view}
/// Displays the Body of LogistaDashboardView
/// {@endtemplate}
class LogistaDashboardView extends StatelessWidget {
  /// {@macro logista_dashboard_view}
  const LogistaDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LogoutSuccess) {
          Navigator.of(context).pushReplacement(
            SigninPage.route(),
          );
        }
      },
      child: const LogistaDashboardBody(),
    );
  }
}
