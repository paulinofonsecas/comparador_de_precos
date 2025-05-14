import 'package:comparador_de_precos/app/config/dependencies.dart';
import 'package:comparador_de_precos/data/repositories/authentication_repository.dart';
import 'package:comparador_de_precos/features/client/application/view/application_page.dart';
import 'package:flutter/material.dart';
import 'package:comparador_de_precos/features/auth/signin/bloc/bloc.dart';
import 'package:comparador_de_precos/features/auth/signin/widgets/signin_body.dart';

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
    return BlocProvider(
      create: (context) => SigninBloc(
        getIt<AuthenticationRepository>(),
      ),
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
    return BlocConsumer<SigninBloc, SigninState>(
      listener: (context, state) {
        if (state is SigninSuccess) {
          Navigator.of(context).pushReplacement(ApplicationPage.route());
        } else if (state is SigninError) {
          // Handle failure state
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error)),
          );
        }
      },
      builder: (context, state) {
        return const SigninBody();
      },
    );
  }
}
