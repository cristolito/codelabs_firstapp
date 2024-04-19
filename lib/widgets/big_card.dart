// lib/widgets/big_card.dart

import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';


class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.pair,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium?.copyWith(
      color: theme.colorScheme.onPrimary,
      height: 2,
    );

    return Card(
      color: theme.colorScheme.primary,
      child: Text(
        pair.asPascalCase,
        style: style,
        semanticsLabel: "${pair.first} ${pair.second}",
      ),
    );
  }
}
