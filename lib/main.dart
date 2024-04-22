// lib/main.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:codelabs_firstapp/providers/app_state_provider.dart';
import 'package:codelabs_firstapp/screens/home_page.dart';
import 'package:codelabs_firstapp/screens/generator_page.dart';
import 'package:codelabs_firstapp/screens/favorite_page.dart';
import 'package:codelabs_firstapp/screens/animate_widgets/pass_argument_page.dart';
import 'package:codelabs_firstapp/screens/animate_widgets/option_page.dart';
import 'package:codelabs_firstapp/screens/persistence/CRUD/create.dart';
import 'package:codelabs_firstapp/screens/persistence/CRUD/read.dart';
import 'package:codelabs_firstapp/screens/persistence/CRUD/update.dart';
import 'package:codelabs_firstapp/screens/persistence/CRUD/delete.dart';
import 'package:codelabs_firstapp/screens/persistence/readwrite.dart';
import 'package:codelabs_firstapp/screens/persistence/keyvalue.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Cookbook',

        initialRoute: '/',
        routes: {
          // When navigating to the "/" route, build the FirstScreen widget.
          '/generator': (context) => GeneratorPage(),
          // When navigating to the "/second" route, build the SecondScreen widget.
          '/favorites': (context) => FavoritePage(),
          '/options': (context) => OptionScreen(),
          '/persistence/CRUD/read': (context) => ReadPage(),
          '/persistence/CRUD/create': (context) => CreatePage(),
          '/persistence/CRUD/update': (context) => UpdatePage(),
          '/persistence/CRUD/delete': (context) => DeletePage(),
          '/persistence/readwrite': (context) => ReadWrite(storage: CounterStorage()),
          '/persistence/keyvalue': (context) => KeyValuePage(),

          ExtractArgumentsScreen.routeName: (context) =>
            const ExtractArgumentsScreen(),
        },
        onGenerateRoute: (settings) {          
          if (settings.name == PassArgumentsScreen.routeName) {
            final args = settings.arguments as ScreenArguments;
            return MaterialPageRoute(
              builder: (context) {
                return PassArgumentsScreen(
                  title: args.title,
                  message: args.message,
                );
              },
            );
          }  else {
            throw Exception('Unknown route: ${settings.name}');
          }
        },
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,

          // Define the default brightness and colors.
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blue,
          ),

          // Define the default `TextTheme`. Use this to specify the default
          // text styling for headlines, titles, bodies of text, and more.
            textTheme: TextTheme(
              displayLarge: const TextStyle(
                fontSize: 42,
                fontWeight: FontWeight.bold,
              ),
              // ···
              titleLarge: GoogleFonts.poppins(
                fontSize: 24,
              ),
              bodyMedium: GoogleFonts.poppins(),
              displaySmall: GoogleFonts.pacifico(),
            ),
          ),
        home: MyHomePage(),
      ),
    );
  }
}
