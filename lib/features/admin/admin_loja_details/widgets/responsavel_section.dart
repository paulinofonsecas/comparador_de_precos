import 'dart:developer';

import 'package:comparador_de_precos/data/models/loja.dart';
import 'package:comparador_de_precos/data/models/user_profile.dart';
import 'package:comparador_de_precos/features/logista/logista_dashboard/cubit/get_logista_profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResponsavelSection extends StatelessWidget {
  const ResponsavelSection({
    required this.loja,
    super.key,
  });

  final Loja loja;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Responsável pela Loja',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        if (loja.profileIdLojista == null || loja.profileIdLojista!.isEmpty)
          const Text('Nenhum responsável definido')
        else
          BlocBuilder<GetLogistaProfileCubit, GetLogistaProfileState>(
            builder: (context, state) {
              if (state is GetLogistaProfileInitial) {
                context
                    .read<GetLogistaProfileCubit>()
                    .getLogistaProfile(loja.profileIdLojista!);
                return const Center(child: CircularProgressIndicator());
              }

              if (state is GetLogistaProfileLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is GetLogistaProfileFailure) {
                log('Erro ao carregar perfil do lojista: ${state.message}');
                return const Center(
                  child:
                      Text('Ocorreu um erro ao carregar o perfil do lojista'),
                );
              } else if (state is GetLogistaProfileSuccess) {
                final logista = state.profile;

                return _Body(logista: logista);
              }

              return const Text('Nenhum responsável definido');
            },
          ),
      ],
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({
    required this.logista,
  });

  final UserProfile logista;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _CustomRowValueWidget(
            title: 'Nome',
            value: logista.nomeCompleto ?? 'Sem Nome',
            icon: Icons.person,
          ),
          const SizedBox(height: 8),
          const _CustomRowValueWidget(
            title: 'E-mail',
            value: 'Sem E-mail',
            icon: Icons.email,
          ),
          const SizedBox(height: 8),
          _CustomRowValueWidget(
            title: 'Telefone',
            value: logista.telefone ?? 'Sem Telefone',
            icon: Icons.phone,
          ),
          const SizedBox(height: 8),
          _CustomRowValueWidget(
            title: 'BI',
            value: logista.bi ?? 'Sem BI',
            icon: Icons.credit_card,
          ),
        ],
      ),
    );
  }
}

class _CustomRowValueWidget extends StatelessWidget {
  const _CustomRowValueWidget({
    required this.title,
    required this.value,
    required this.icon,
  });

  final String title;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        Row(
          children: [
            Icon(icon, size: 18, color: Colors.grey[700]),
            const SizedBox(width: 4),
            Expanded(
              child: Text(value),
            ),
          ],
        ),
      ],
    );
  }
}
