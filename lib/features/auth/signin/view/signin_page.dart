import 'package:comparador_de_precos/app/config/dependencies.dart';
import 'package:comparador_de_precos/data/models/user_profile.dart';
import 'package:comparador_de_precos/data/repositories/authentication_repository.dart';
import 'package:comparador_de_precos/features/admin/admin_dashboard/view/admin_dashboard_page.dart';
import 'package:comparador_de_precos/features/auth/signin/bloc/bloc.dart';
import 'package:comparador_de_precos/features/auth/signin/widgets/signin_body.dart';
import 'package:comparador_de_precos/features/auth/signup/bloc/signup_bloc.dart';
import 'package:comparador_de_precos/features/consumer/application/view/application_page.dart';
import 'package:comparador_de_precos/features/logista/logista_dashboard/logista_dashboard.dart';
import 'package:flutter/material.dart';

/// {@template signin_page}
/// A description for SigninPage
/// {@endtemplate}
class SigninPage extends StatelessWidget {
  /// {@macro signin_page}
  const SigninPage({super.key});

  /// The static route for SigninPage
  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(builder: (_) => const SigninPage());
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SigninBloc(
            getIt<AuthenticationRepository>(),
          )..add(const CheckUserLocalLoginEvent()),
        ),
        BlocProvider.value(
          value: getIt<SignupBloc>(),
        ),
      ],
      child: const Scaffold(
        body: SigninView(),
      ),
    );
  }
}

/// {@template signin_view}
/// Displays the Body of SigninView
/// {@endtemplate}
class SigninView extends StatelessWidget {
  /// {@macro signin_view}
  const SigninView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<SigninBloc, SigninState>(
          listener: (context, state) {
            if (state is SigninSuccess) {
              if (state.user.userType! == UserType.consumidor.name) {
                Navigator.of(context).pushReplacement(
                  ApplicationPage.route(),
                );
              }

              if (state.user.userType! == UserType.lojista.name) {
                Navigator.of(context).pushReplacement(
                  LogistaDashboardPage.route(
                    user: state.user,
                  ),
                );
              }

              if (state.user.userType! == UserType.admin.name) {
                Navigator.of(context).pushReplacement(
                  AdminDashboardPage.route(
                    user: state.user,
                  ),
                );
              }
            } else if (state is SigninError) {
              late final String errorMessage;

              if (state.error.contains("Failed host lookup")) {
                errorMessage = 'Falha na comunicação com o servidor. '
                    'Verifique a sua conexão e tente novamente';
              } else {
                errorMessage = 'Usuário ou senha incorretos';
              }

              // Handle failure state
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(errorMessage),
                ),
              );
            }
          },
        ),
        BlocListener<SignupBloc, SignupState>(
          listener: (context, state) {
            if (state is SignupSuccessState) {
              context.read<SigninBloc>().add(
                    const CheckUserLocalLoginEvent(),
                  );
            }

            if (state is SignupErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Ocorreu um erro ao cadastrar'),
                ),
              );
            }
          },
        ),
      ],
      child: const SigninBody(),
    );
  }
}
