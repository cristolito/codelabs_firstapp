import 'dart:async';

import 'package:codelabs_firstapp/models/dog_model.dart';
import 'package:flutter/material.dart';
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

Future<void> deleteDog(int id, BuildContext context) async {
  final dog = await fetchDog(id);
  if (dog.id != 0) {
    final db = await initializeDatabase();
    await db.delete(
      'dogs',
      where: 'id = ?',
      whereArgs: [id],
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Dog deleted successfully!'),
      ),
    );
  } 
}

Future<Dog> fetchDog(int id) async {
  final db = await initializeDatabase();

  final List<Map<String, dynamic>> dogList = await db.query('dogs', where: 'id = ?', whereArgs: [id]);

  if (dogList.isNotEmpty) {
    return Dog(
      id: dogList[0]['id'] as int,
      name: dogList[0]['name'] as String,
      age: dogList[0]['age'] as int,
    );
  } else {
    return Dog(id: 0, name: '', age: 0);
  }
}


class DeletePage extends StatefulWidget {
  const DeletePage({super.key});

  @override
  State<DeletePage> createState() => _DeletePageState();
}

class _DeletePageState extends State<DeletePage> {
  late Future<Database> database;
  late Future<Dog?> futureDog = Future.value();
  final idController = TextEditingController();

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
    //final futureDog = database.then((db) => fetchDog(int.parse(idController.text)));
    return Scaffold(
      appBar: AppBar(
          title: const Text('Delete: borra 1 perro de la db'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0), 
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                controller: idController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(hintText: 'Write a ID')
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () async {
                  final dog = await fetchDog(int.parse(idController.text));
                  setState(() {
                    futureDog = Future.value(dog);
                  });
                },
                child: Text('Obtener perro a eliminar:'),
              ),
              SizedBox(height: 16),
              FutureBuilder<Dog?>(
                future: futureDog,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      return Text(
                        'ID: ${snapshot.data!.id}\n'
                        'Name: ${snapshot.data!.name}\n'
                        'Age: ${snapshot.data!.age}\n',
                      );
                    } else {
                      return Text('No se encontró el perro.');
                    }
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }
                  return CircularProgressIndicator();
                },
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: ()async {
                  final dog = await futureDog; 
                  setState(() {
                    if (dog != null) {
                      deleteDog(dog.id, context);
                    }
                  });
                },
                child: Text('Eliminar perro'),
              ),
            ],
          ),
        ),
    );
  }
}