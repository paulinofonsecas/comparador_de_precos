import 'package:flutter/material.dart';

class CustomSearchWidget extends StatelessWidget {
  const CustomSearchWidget({
    super.key,
    required this.textController,
  });

  final TextEditingController textController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: SearchBar(
        controller: textController,
        hintText: 'Pesquisar loja',
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
    );
  }
}