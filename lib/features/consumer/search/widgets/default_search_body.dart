import 'package:comparador_de_precos/features/consumer/search/cubit/search_history_cubit.dart';
import 'package:comparador_de_precos/features/consumer/search/widgets/historic_itens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DefaultSearchBody extends StatefulWidget {
  const DefaultSearchBody({
    required this.onItemTap, super.key,
  });

  final void Function(String) onItemTap;

  @override
  State<DefaultSearchBody> createState() => _DefaultSearchBodyState();
}

class _DefaultSearchBodyState extends State<DefaultSearchBody> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BlocConsumer<SearchHistoryCubit, SearchHistoryState>(
          bloc: context.read<SearchHistoryCubit>()..retriveItems(),
          listener: (context, state) {
            if (state is SearchHistoryRemovedItem) {
              context.read<SearchHistoryCubit>().retriveItems();
            }
          },
          builder: (context, state) {
            if (state is SearchHistorySuccess) {
              return HistoricItens(
                history: state.history,
                onItemTap: widget.onItemTap,
                onRemoveTap: (historyItem) {
                  context
                      .read<SearchHistoryCubit>()
                      .removeItem(historyItem);
                },
              );
            }

            return HistoricItens(
              history: const [],
              onItemTap: (historyItem) {},
              onRemoveTap: (historyItem) {},
            );
          },
        ),
        const Divider(),
      ],
    );
  }
}
