import 'package:comparador_de_precos/features/admin/admin_dashboard/cubit/get_lojas_info_cubit.dart';
import 'package:comparador_de_precos/features/admin/admin_dashboard/widgets/metric_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

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
      child: BlocBuilder<GetLojasInfoCubit, GetLojasInfoState>(
        bloc: context.read<GetLojasInfoCubit>()..fetchLojasInfo(),
        builder: (context, state) {
          if (state is GetLojasInfoLoading) {
            return const Skeletonizer(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MetricItemWidget(
                    key: Key('total_users_metric'),
                    title: 'Lojas Autorizadas',
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

          if (state is GetLojasInfoSuccess) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MetricItemWidget(
                  key: const Key('total_users_metric'),
                  title: 'Lojas Autorizadas',
                  icon: Icons.store,
                  value: state.lojasInfo['totalLojas']?.toString() ?? '0',
                ),
                MetricItemWidget(
                  key: const Key('total_products_metric'),
                  title: 'Lojas por avaliar',
                  icon: Icons.search,
                  value: state.lojasInfo['lojasParaAvaliar']?.toString() ?? '0',
                ),
              ],
            );
          }

          if (state is GetLojasInfoFailure) {
            return const Center(child: Text('Erro ao carregar informações'));
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
