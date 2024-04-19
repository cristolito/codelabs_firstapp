// lib/screens/favorite_page.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:codelabs_firstapp/providers/app_state_provider.dart';
import 'package:codelabs_firstapp/models/word_pair_model.dart';

class FavoritePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return appState.favorites.isEmpty
        ? _buildEmptyFavorites()
        : _buildFavoritesList(appState.favorites);
  }

  Widget _buildEmptyFavorites() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Palabras favoritas'),
      ),
      body: Center(
        child: Text('No tienes ningún favorito.'),
      ),
    );
  }

  Widget _buildFavoritesList(List<WordPairModel> favorites) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Palabras favoritas'),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text('Tienes ${favorites.length} palabras favoritas:'),
          ),
          for (var pair in favorites)
            ListTile(
              leading: Icon(Icons.favorite),
              title: Text(pair.pair.asPascalCase),
            ),
        ],
      ),
    );
  }
}
