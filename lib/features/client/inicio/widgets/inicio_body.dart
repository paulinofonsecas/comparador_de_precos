import 'package:comparador_de_precos/features/client/inicio/widgets/market_scroll_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';

/// {@template inicio_body}
/// Body of the InicioPage.
///
/// Add what it does
/// {@endtemplate}
class InicioBody extends StatelessWidget {
  /// {@macro inicio_body}
  const InicioBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Top10MelhoreLojasWidget(),
            const GutterLarge(),
            const Top10MelhoreLojasWidget(),
            const GutterLarge(),
            Row(
              children: [
                Text(
                  'Recomendado para você',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const Spacer(),
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.chevron_right),
                  iconAlignment: IconAlignment.end,
                  label: const Text('Ver todas', style: TextStyle(fontSize: 13)),
                ),
              ],
            ),
            const GutterLarge(),
          ],
        ),
      ),
    );
  }
}

class Top10MelhoreLojasWidget extends StatelessWidget {
  const Top10MelhoreLojasWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              'Top 10 melhores Lojas',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const Spacer(),
            TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.chevron_right),
              iconAlignment: IconAlignment.end,
              label: const Text('Ver todas', style: TextStyle(fontSize: 13)),
            ),
          ],
        ),
        const GutterSmall(),
        const SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            spacing: 4,
            children: [
              MarketScrollListItem(),
              MarketScrollListItem(),
              MarketScrollListItem(),
            ],
          ),
        ),
      ],
    );
  }
}
