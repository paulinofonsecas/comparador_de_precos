import 'package:flutter/material.dart';

class MetricItemWidget extends StatelessWidget {
  const MetricItemWidget({
    required this.title,
    required this.icon,
    required this.value,
    super.key,
  });

  final String title;
  final IconData icon;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          size: 30,
          color: Colors.blue,
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text(
          title,
          style: const TextStyle(fontSize: 13),
        ),
      ],
    );
  }
}
