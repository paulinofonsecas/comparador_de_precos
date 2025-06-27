import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';

class UserInfoWidget extends StatelessWidget {
  const UserInfoWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        CircleAvatar(
          radius: 35,
          backgroundImage: NetworkImage(
            'https://www.gravatar.com/avatar/placeholder.png',
          ),
        ),
        Gutter(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Paulino Fonseca',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
            ),
            Text(
              'paulinofonsecass@gmail.com',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ],
    );
  }
}
