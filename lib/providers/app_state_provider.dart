// lib/providers/app_state_provider.dart

import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:codelabs_firstapp/models/word_pair_model.dart';

class MyAppState extends ChangeNotifier {
  var current = WordPairModel(WordPair.random());

  void getNext() {
    current = WordPairModel(WordPair.random());
    notifyListeners();
  }

  var favorites = <WordPairModel>[];

  void toggleFavorite() {
    if (favorites.contains(current)) {
      favorites.remove(current);
    } else {
      favorites.add(current);
    }
    notifyListeners();
  }
}