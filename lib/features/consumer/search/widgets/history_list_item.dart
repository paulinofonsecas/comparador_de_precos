import 'package:flutter/material.dart';

class HistoryListItem extends StatelessWidget {
  const HistoryListItem({
    required this.title,
    required this.onItemTap,
    required this.onRemoveTap,
    super.key,
  });

  final String title;
  final void Function(String) onItemTap;
  final void Function(String) onRemoveTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        onItemTap(title);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 8,
        ),
        child: Row(
          spacing: 8,
          children: [
            const Icon(Icons.history, size: 24),
            Text(title),
            const Spacer(),
            InkWell(
              borderRadius: BorderRadius.circular(16),
              child: const Icon(Icons.close, size: 24),
              onTap: () {
                onRemoveTap(title);
              },
            ),
          ],
        ),
      ),
    );
  }
}
