import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:codelabs_firstapp/providers/app_state_provider.dart';

class SnackBarPage extends StatelessWidget {
  const SnackBarPage({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    return MaterialApp(
      home: Scaffold(
        body: DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              bottom: const TabBar(
                tabs: [
                  Tab(icon: Icon(Icons.swipe_right_rounded)),
                  Tab(icon: Icon(Icons.radio_button_checked)),
                  Tab(icon: Icon(Icons.indeterminate_check_box_sharp)),
                ],
              ),
              title: const Text('Tabs, Snack, GFonts, Horizontal lista, listas espaciadas'),
            ),
            body: TabBarView(
              children: [
                // First Tab
                _buildFirstTabContent(appState),
                // Second Tab
                _buildSecondTabContent(context),
                // Third Tab
                _buildThirdTabContent(appState),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFirstTabContent(MyAppState appState) {
    return Container(
      color: Color.fromARGB(149, 192, 83, 83),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: appState.favorites.length, // Adjust the number of items as needed
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.all(8.0),
            width: 100.0,
            height: 100.0,
            color: Colors.yellow,
            child: Center(
              child: Text(
                appState.favorites[index].pair.asPascalCase,
                style: TextStyle(fontSize: 16.0),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSecondTabContent(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: Center(
        child: ElevatedButton(
          onPressed: () {
            final snackBar = SnackBar(
              content: Text('Esto es una snackbar!'),
              action: SnackBarAction(
                label: 'Borrar',
                onPressed: () {
                  // Some code to undo the change.
                },
              ),
            );

            // Find the ScaffoldMessenger in the widget tree
            // and use it to show a SnackBar.
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          },
          child: Text(
            'Show SnackBar',
            style: GoogleFonts.lato(),
          ),
        ),
      ),
    );
  }

  Widget _buildThirdTabContent(MyAppState appState) {
    return SingleChildScrollView (
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: List.generate(
            appState.favorites.length,
            (index) => ItemWidget(text: appState.favorites[index].pair.asPascalCase),
        ),
      ), 
    );
  }
}

class ItemWidget extends StatelessWidget {
  const ItemWidget({
    Key? key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        height: 100,
        child: Center(child: Text(text)),
      ),
    );
  }
}