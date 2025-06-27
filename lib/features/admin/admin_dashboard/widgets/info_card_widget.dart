import 'package:comparador_de_precos/features/admin/admin_dashboard/widgets/admin_dashboard_body.dart';
import 'package:comparador_de_precos/features/admin/admin_dashboard/widgets/metric_item_widget.dart';
import 'package:flutter/material.dart';

class InfoCardWidget extends StatelessWidget {
  const InfoCardWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 1,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          MetricItemWidget(
            key: Key('total_users_metric'),
            title: 'Lojas Cadastradas',
            icon: Icons.store,
            value: '1,234',
          ),
          MetricItemWidget(
            key: Key('total_products_metric'),
            title: 'Lojas por avaliar',
            icon: Icons.search,
            value: '5,678',
          ),
        ],
      ),
    );
  }
}
