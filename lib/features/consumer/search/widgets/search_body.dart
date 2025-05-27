import 'package:comparador_de_precos/data/models/produto.dart';
import 'package:comparador_de_precos/features/consumer/search/cubit/search_history_cubit.dart'
    show SearchHistoryCubit;
import 'package:comparador_de_precos/features/consumer/search/search.dart';

import 'default_search_body.dart';
import 'package:flutter/material.dart';

class SearchBody extends StatefulWidget {
  const SearchBody({super.key});

  @override
  State<SearchBody> createState() => _SearchBodyState();
}

class _SearchBodyState extends State<SearchBody> {
  final textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    textController.addListener(() {
      context.read<SearchBloc>().add(SearchProductEvent(textController.text));
      setState(() {});
    });
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SearchBar(
            controller: textController,
            hintText: 'Pesquisar produtos 🧃',
            onChanged: (value) {},
            elevation: const WidgetStatePropertyAll(3),
            backgroundColor: WidgetStatePropertyAll(
              Theme.of(context).colorScheme.surface,
            ),
            leading: const Icon(Icons.search),
            trailing: [
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: textController.clear,
              ),
            ],
            shape: const WidgetStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(16),
                ),
              ),
            ),
          ),
        ),
        if (textController.text.isNotEmpty)
          ResultSearchList(
            searchText: textController.text,
          ),
        if (textController.text.isEmpty)
          DefaultSearchBody(
            onItemTap: (String item) {
              textController.text = item;
            },
          ),
      ],
    );
  }
}

class ResultSearchList extends StatefulWidget {
  const ResultSearchList({
    required this.searchText,
    super.key,
  });

  final String searchText;

  @override
  State<ResultSearchList> createState() => _ResultSearchListState();
}

class _ResultSearchListState extends State<ResultSearchList> {
  List<Produto> produtsResult = <Produto>[];

  @override
  Widget build(BuildContext context) {
    return BlocListener<SearchBloc, SearchState>(
      listener: (context, state) {
        if (state is SearchProductsSuccess) {
          produtsResult
            ..clear()
            ..addAll(state.produtsResult);
          setState(() {});
        }
      },
      child: Expanded(
        child: BlocBuilder<SearchBloc, SearchState>(
          builder: (context, state) {
            if (state is SearchProductsError) {
              return const Center(
                child: Text('Ocorreu um erro ao realizar a pesquisa'),
              );
            }

            return Column(
              children: [
                if (state is SearchProductsLoading)
                  const LinearProgressIndicator(),
                Expanded(
                  child: ListView.builder(
                    itemCount: produtsResult.length,
                    itemBuilder: (context, index) {
                      final item = produtsResult[index];

                      return ListTile(
                        title: Text(item.nome),
                        subtitle: const Text('1.250 Kz, em 10 lojas'),
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            'https://www.pontotel.com.br/local/wp-content/uploads/2022/05/imagem-corporativa.webp',
                            width: 64,
                            height: 64,
                            fit: BoxFit.cover,
                          ),
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                        onTap: () {
                          context.read<SearchHistoryCubit>().saveItem(
                                widget.searchText,
                              );
                        },
                      );
                    },
                  ),
                ),
                if (state is SearchProductsEmpty)
                  const Center(child: Text('Sem nenhum resultado')),
              ],
            );
          },
        ),
      ),
    );
  }
}
