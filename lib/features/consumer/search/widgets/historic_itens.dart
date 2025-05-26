import 'package:comparador_de_precos/features/consumer/search/widgets/history_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';

class HistoricItens extends StatelessWidget {
  const HistoricItens({
    super.key,
    required this.history,
    required this.onItemTap,
    required this.onRemoveTap,
  });

  final List<String> history;
  final void Function(String) onItemTap;
  final void Function(String) onRemoveTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Historico de buscas',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
          ),
          const GutterSmall(),
          Column(
            children: history
                .take(6)
                .map((e) => HistoryListItem(
                      title: e,
                      onItemTap: onItemTap,
                      onRemoveTap: onRemoveTap,
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}
