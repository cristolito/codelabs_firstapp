// lib/screens/listview_page.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:codelabs_firstapp/providers/app_state_provider.dart';
import 'package:transparent_image/transparent_image.dart';

class ListViewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Vista de lista'),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
              // Provide a standard title.
              title: Text('Floating App'),
              // Allows the user to reveal the app bar if they begin scrolling
              // back up the list of items.
              floating: true,
              // Display a placeholder widget to visualize the shrinking size.
              flexibleSpace: FadeInImage.memoryNetwork(
                placeholder: kTransparentImage, 
                image: 'https://picsum.photos/250?image=9',
                fit: BoxFit.cover,
                ),
              expandedHeight: 200,
            ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => ListTile(
                tileColor: Color.fromARGB(255, 222, 173, 250),
                textColor: const Color.fromARGB(255, 0, 0, 0),
                leading: Text('${index + 1}'),
                title: Text(appState.favorites[index].pair.asPascalCase),
                horizontalTitleGap: 2,
                minVerticalPadding: 30,
              ),
              childCount: appState.favorites.length,
            ),
          ),
        ],
      ),
    );
  }
}
