import 'package:flutter/material.dart';

typedef AsyncLoader<T> = Future<List<T>> Function(String search);

typedef ItemToString<T> = String Function(T item);
typedef ItemSubtitle<T> = String? Function(T item);
typedef OnItemSelected<T> = void Function(T selected);

class DefaultSearchBottomSheet<T> extends StatefulWidget {
  const DefaultSearchBottomSheet({
    required this.items,
    required this.itemToString,
    required this.onItemSelected,
    this.title,
    this.itemSubtitle,
    this.asyncLoader,
    super.key,
  });

  final List<T> items;
  final ItemToString<T> itemToString;
  final ItemSubtitle<T>? itemSubtitle;
  final OnItemSelected<T> onItemSelected;
  final String? title;
  final AsyncLoader<T>? asyncLoader;

  static Future<T?> show<T>({
    required BuildContext context,
    required ItemToString<T> itemToString,
    List<T>? items,
    ItemSubtitle<T>? itemSubtitle,
    String? title,
    AsyncLoader<T>? asyncLoader,
  }) async {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height * 0.85,
        maxHeight: MediaQuery.of(context).size.height * 0.85,
      ),
      builder: (context) {
        return DefaultSearchBottomSheet<T>(
          items: items ?? const [],
          itemToString: itemToString,
          itemSubtitle: itemSubtitle,
          onItemSelected: (selected) {
            Navigator.of(context).pop(selected);
          },
          title: title,
          asyncLoader: asyncLoader,
        );
      },
    );
  }

  @override
  State<DefaultSearchBottomSheet<T>> createState() =>
      _DefaultSearchBottomSheetState<T>();
}

class _DefaultSearchBottomSheetState<T>
    extends State<DefaultSearchBottomSheet<T>> {
  late List<T> filteredItems;
  String search = '';
  bool loading = false;

  @override
  void initState() {
    super.initState();
    filteredItems = widget.items;
  }

  Future<void> _loadAsync(String value) async {
    setState(() {
      loading = true;
    });
    final result = await widget.asyncLoader!(value);
    setState(() {
      filteredItems = result;
      loading = false;
    });
  }

  void _onSearchChanged(String value) {
    if (widget.asyncLoader != null) {
      _loadAsync(value);
    } else {
      setState(() {
        search = value;
        filteredItems = widget.items
            .where(
              (item) => widget
                  .itemToString(item)
                  .toLowerCase()
                  .contains(search.toLowerCase()),
            )
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.title != null)
              Padding(
                padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
                child: Text(
                  widget.title!,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                decoration: const InputDecoration(
                  hintText: 'Pesquisar...',
                  prefixIcon: Icon(Icons.search),
                ),
                onChanged: _onSearchChanged,
              ),
            ),
            const SizedBox(height: 8),
            Flexible(
              child: loading
                  ? const Center(
                      child: Padding(
                        padding: EdgeInsets.all(32),
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : filteredItems.isEmpty
                      ? const Padding(
                          padding: EdgeInsets.all(24),
                          child: Text('Nenhum item encontrado.'),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: filteredItems.length,
                          itemBuilder: (context, index) {
                            final item = filteredItems[index];
                            return ListTile(
                              title: Text(widget.itemToString(item)),
                              subtitle: widget.itemSubtitle != null
                                  ? (widget.itemSubtitle!(item) != null
                                      ? Text(widget.itemSubtitle!(item)!)
                                      : null)
                                  : null,
                              onTap: () => widget.onItemSelected(item),
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
