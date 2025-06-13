import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';

class DashboardCardItem extends StatelessWidget {
  const DashboardCardItem({
    required this.title, required this.icon, super.key,
    this.onTap,
  });

  final String title;
  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 48,
              color: onTap != null
                  ? Theme.of(context).colorScheme.primary
                  : Colors.grey,
            ),
            const Gutter(),
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      ),
    );
  }
}
