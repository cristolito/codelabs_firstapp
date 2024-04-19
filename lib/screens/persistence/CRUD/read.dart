import 'dart:async';

import 'package:flutter/material.dart';
import 'package:codelabs_firstapp/models/dog_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Future<Database> initializeDatabase() async {
  final path = join(await getDatabasesPath(), 'doggie_database.db');
  print('Database path: $path');

  var db = openDatabase(
      path,
      onCreate: (db, version) {
        print('Creating dogs table. Database version: $version');
        print('Creating dogs table');
        return db.execute(
          'CREATE TABLE dogs(id INTEGER PRIMARY KEY, name TEXT, age INTEGER)',
        );
      },
      version: 2,
    );
    print('Database opened successfully');
    return db;
}


Future<List<Dog>> fetchDogList(Database db) async {
  // Query the table for all The Dogs.
  final List<Map<String, dynamic>> maps = await db.query('dogs');

  // Convert the List<Map<String, dynamic> into a List<Dog>.
  return List.generate(maps.length, (i) {
    return Dog(
      id: maps[i]['id'] as int,
      name: maps[i]['name'] as String,
      age: maps[i]['age'] as int,
    );
  });
}

class ReadPage extends StatefulWidget {
  const ReadPage({super.key});

  @override
  State<ReadPage> createState() => _MyAppState();
}

class _MyAppState extends State<ReadPage> {
  late Future<Database> database;
  late Future<List<Dog>> futureDogList = Future.value([]);

  @override
  void initState() {
    super.initState();
    initializeDatabase().then((db) {
      print('Database initialized successfully');
      setState(() {
        database = Future.value(db);
      });
    }).catchError((error) {
      print('Error initializing database: $error');
    });
  }

  @override
  void dispose() {
    super.dispose();
    database.then((db) => db.close());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('GetAll: muestra todos los perros'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(
                onPressed: () {
                    setState(() {
                      futureDogList = database.then((db) => fetchDogList(db));
                    });
                },
                child: Text('Obtener lista de perros:'),
              ),
              SizedBox(height: 16),
              FutureBuilder<List<Dog>>(
                future: futureDogList,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                      return Column(
                        children: snapshot.data!.map((dog) {
                          return Text(
                            'ID: ${dog.id}\n'
                            'Name: ${dog.name}\n'
                            'Age: ${dog.age}\n',
                          );
                        }).toList(),
                      );
                    } 
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                  return const CircularProgressIndicator();
                },
              ),
            ],
          ),
        ),
    );
  }
}