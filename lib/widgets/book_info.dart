import 'package:flutter/material.dart';

import '../utils/styles.dart';

class BookInfo extends StatelessWidget {
  const BookInfo({super.key,
    required this.infoKey,
    required this.value,
  });

  final String infoKey;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(infoKey, style: Styles.keyStyle),
            Text(
              value,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
        const SizedBox(height: 8)
      ],
    );
  }
}
