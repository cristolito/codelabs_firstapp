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
        title: 'Codelabs',

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
            seedColor: Color.fromARGB(255, 1, 4, 8),
            primary: Color.fromARGB(255, 49, 103, 169),
            onPrimary: Color.fromARGB(255, 241, 241, 241),
            secondary: Color.fromARGB(255, 0, 109, 98),
            onSecondary: Color.fromARGB(255, 216, 216, 216),
            tertiary: Color.fromARGB(255, 30, 30, 30),
            onTertiary: Color.fromARGB(255, 216, 216, 216),
            outline: Color.fromARGB(255, 222, 0, 0),
            brightness: Brightness.dark,
          ),

          // Define the default `TextTheme`. Use this to specify the default
          // text styling for headlines, titles, bodies of text, and more.
            textTheme: TextTheme(
              displayLarge: const TextStyle(
                fontSize: 72,
                fontWeight: FontWeight.bold,
              ),
              // ···
              titleLarge: GoogleFonts.oswald(
                fontSize: 30,
              ),
              bodyMedium: GoogleFonts.merriweather(),
              displaySmall: GoogleFonts.pacifico(),
            ),
          ),
        home: MyHomePage(),
      ),
    );
  }
}
