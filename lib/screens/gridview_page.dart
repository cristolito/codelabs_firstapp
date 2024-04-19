// lib/screens/gridview_page.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:codelabs_firstapp/providers/app_state_provider.dart';

class GridViewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Vista de parrilla & UI orientacion'),
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          return Container(
          color: Theme.of(context).colorScheme.primaryContainer, // Set background color from theme
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: orientation == Orientation.portrait ? 2 : 3,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
            ),
            itemCount: appState.favorites.length,
            itemBuilder: (context, index) {
              return Container(
                color: Theme.of(context).primaryColor, // Set item color from theme
                child: Center(
                  child: Text(
                    appState.favorites[index].pair.asPascalCase,
                    style: TextStyle(color: Colors.white),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
