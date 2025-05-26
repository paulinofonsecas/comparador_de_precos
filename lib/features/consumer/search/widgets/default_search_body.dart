import 'package:comparador_de_precos/features/consumer/search/widgets/historic_itens.dart';
import 'package:comparador_de_precos/features/consumer/search/widgets/most_popular.dart';
import 'package:flutter/material.dart';

class DefaultSearchBody extends StatefulWidget {
  const DefaultSearchBody({
    super.key,
    required this.onItemTap,
  });

  final void Function(String) onItemTap;

  @override
  State<DefaultSearchBody> createState() => _DefaultSearchBodyState();
}

class _DefaultSearchBodyState extends State<DefaultSearchBody> {
  var history = <String>[
    'Notebook',
    'Smartphone',
    'Tablet',
    'Monitor',
    'Mouse',
    'Teclado',
    'Cadeira',
    'Impressora',
  ];
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HistoricItens(
              history: history,
              onItemTap: widget.onItemTap,
              onRemoveTap: (historyItem) {
                setState(() {
                  history.remove(historyItem);
                });
              },
            ),
            const Divider(),
            const MostPopular(),
          ],
        ),
      ),
    );
  }
}
