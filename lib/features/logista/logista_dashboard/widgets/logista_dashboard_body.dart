import 'package:comparador_de_precos/features/auth/signin/cubit/login_cubit.dart';
import 'package:comparador_de_precos/features/logista/logista_dashboard/bloc/bloc.dart';
import 'package:comparador_de_precos/features/logista/logista_dashboard/cubit/get_logista_profile_cubit.dart';
import 'package:comparador_de_precos/features/logista/logista_dashboard/widgets/dashboard_card_item.dart';
import 'package:comparador_de_precos/features/logista/logista_produtos_associados/view/logista_produtos_associados_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// {@template logista_dashboard_body}
/// Body of the LogistaDashboardPage.
///
/// Add what it does
/// {@endtemplate}
class LogistaDashboardBody extends StatelessWidget {
  /// {@macro logista_dashboard_body}
  const LogistaDashboardBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetLogistaProfileCubit, GetLogistaProfileState>(
      builder: (context, state) {
        if (state is GetLogistaProfileLoading) {
          return const CircularProgressIndicator();
        }

        if (state is GetLogistaProfileFailure) {
          return Center(
            child: ElevatedButton(
              onPressed: () {
              },
              child: const Text('Tentar novamente.'),
            ),
          );
        }

        if (state is GetLogistaProfileSuccess) {
          return const _Body();
        }

        return const SizedBox.shrink();
      },
    );
  }
}

// ignore: camel_case_types
class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        children: [
          DashboardCardItem(
            title: 'Produtos',
            icon: Icons.edit_document,
            onTap: () {
              Navigator.push(
                context,
                LogistaProdutosAssociadosPage.route(),
              );
            },
          ),
          DashboardCardItem(
            title: 'Promoções',
            icon: Icons.event_busy,
            onTap: () {},
          ),
          const DashboardCardItem(
            title: 'Relatórios',
            icon: Icons.bar_chart,
          ),
          const DashboardCardItem(
            title: 'Configurações',
            icon: Icons.settings,
          ),
          DashboardCardItem(
            title: 'Sair',
            icon: Icons.logout,
            onTap: () {
              context.read<LoginCubit>().signOut();
            },
          ),
        ],
      ),
    );
  }
}
