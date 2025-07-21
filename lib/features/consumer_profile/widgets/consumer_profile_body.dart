import 'package:comparador_de_precos/app/config/dependencies.dart';
import 'package:comparador_de_precos/features/auth/bloc/auth_bloc.dart';
import 'package:comparador_de_precos/features/auth/signup/view/solicitar_cadastro_loja_page.dart';
import 'package:comparador_de_precos/features/consumer_profile/cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';

/// {@template consumer_profile_body}
/// Body of the ConsumerProfilePage.
///
/// Add what it does
/// {@endtemplate}
class ConsumerProfileBody extends StatelessWidget {
  /// {@macro consumer_profile_body}
  const ConsumerProfileBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  // ignore: inference_failure_on_instance_creation
                  MaterialPageRoute(
                    builder: (_) => const SolicitarCadastroLojaPage(),
                  ),
                );
              },
              child: Text(
                'Deseja cadastrar uma loja?',
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              ),
            ),
            const Gutter(),
            ElevatedButton(
              onPressed: () {
                getIt<AuthBloc>().add(SignOutEvent());
              },
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
