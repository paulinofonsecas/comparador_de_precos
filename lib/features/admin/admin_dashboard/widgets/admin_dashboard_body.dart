import 'dart:developer';

import 'package:comparador_de_precos/features/admin/admin_dashboard/widgets/custom_list_tile.dart';
import 'package:comparador_de_precos/features/admin/admin_dashboard/widgets/info_card_widget.dart';
import 'package:comparador_de_precos/features/admin/admin_dashboard/widgets/user_info_widget.dart';
import 'package:comparador_de_precos/features/admin/admin_gestao_lojas/admin_gestao_lojas.dart';
import 'package:comparador_de_precos/features/admin/admin_solicitacoes_lojas/view/admin_solicitacoes_lojas_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';

/// {@template admin_dashboard_body}
/// Body of the AdminDashboardPage.
///
/// Add what it does
/// {@endtemplate}
class AdminDashboardBody extends StatelessWidget {
  /// {@macro admin_dashboard_body}
  const AdminDashboardBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const UserInfoWidget(),
          const GutterLarge(),
          const InfoCardWidget(),
          const GutterLarge(),
          CustomListTile(
            title: 'Gestão de Lojas',
            icon: Icons.store,
            onTap: () {
              Navigator.of(context).push(
                AdminGestaoLojasPage.route(),
              );
            },
          ),
          const Gutter(),
          // Lojas para avaliação
          CustomListTile(
            title: 'Solicitações de lojas',
            icon: Icons.add,
            onTap: () {
              Navigator.of(context).push(
                AdminSolicitacoesLojasPage.route(),
              );
            },
          ),
          const Gutter(),
          CustomListTile(
            title: 'Gestão de Produtos',
            icon: Icons.shopping_bag,
            onTap: () {
              log('Gestão de Produtos tapped');
            },
          ),
          const Gutter(),
          CustomListTile(
            title: 'Gestão de categorias',
            icon: Icons.category,
            onTap: () {
              log('Gestão de categorias tapped');
            },
          ),
          const Gutter(),
          CustomListTile(
            title: 'Gestão de Avaliações',
            icon: Icons.rate_review,
            onTap: () {
              log('Gestão de Avaliações tapped');
            },
          ),
        ],
      ),
    );
  }
}
