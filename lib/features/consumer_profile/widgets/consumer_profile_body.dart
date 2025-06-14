import 'package:comparador_de_precos/features/auth/bloc/auth_bloc.dart';
import 'package:comparador_de_precos/features/consumer_profile/cubit/cubit.dart';
import 'package:flutter/material.dart';

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
    return Center(
      child: ElevatedButton(
        onPressed: () {
          context.read<AuthBloc>().add(SignOutEvent());
        },
        child: const Text('Logout'),
      ),
    );
  }
}
