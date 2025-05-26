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
        if (textController.text.isNotEmpty) const ResultSearchList(),
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

class ResultSearchList extends StatelessWidget {
  const ResultSearchList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Produto $index'),
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
            onTap: () {},
          );
        },
      ),
    );
  }
}
