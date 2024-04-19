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

Future<void> updateDog(int id, String name, int age, BuildContext context) async {
  // Get a reference to the database.
  final db = await initializeDatabase();
  var dog = Dog(id: id, name: name, age: age);
  // Update the given Dog.
  await db.update(
    'dogs',
    dog.toMap(),
    // Ensure that the Dog has a matching id.
    where: 'id = ?',
    // Pass the Dog's id as a whereArg to prevent SQL injection.
    whereArgs: [id],
  );
  
  ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Dog updated successfully!'),
      ),
    );
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


class UpdatePage extends StatefulWidget {
  const UpdatePage({super.key});

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  late Future<Database> database;
  late Future<Dog?> futureDog = Future.value();
  final idController = TextEditingController();
  final nameController = TextEditingController();
  final ageController = TextEditingController();

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
      appBar: AppBar(title: Text('Update a dog')),
      body: SingleChildScrollView(
        child: Form(
          child: Column(
            children: <Widget>[
              SizedBox(height: 16, child: Text('Id del perro a actualizar')),
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
                child: Text('Obtener perro a actualizar:'),
              ),
              FutureBuilder<Dog?>(
                future: futureDog,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    final dog = snapshot.data;
                    if (dog != null) {
                      return Column(
                        children: [
                          SizedBox(height: 30, child: Text('Dogs Name'),),
                          TextFormField(
                            controller: nameController,
                            decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              hintText: dog.name,
                              hintStyle: TextStyle(color: Color.fromARGB(255, 182, 182, 182)),
                            ),
                            // The validator receives the text that the user has entered.
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Write a name.';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 30, child: Text('Dogs Age'),),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            controller: ageController,
                            decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              hintText: dog.age.toString(),
                              hintStyle: TextStyle(color: Color.fromARGB(255, 182, 182, 182)),
                            ),
                            // The validator receives the text that the user has entered.
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Write a number.';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 30),
                          ElevatedButton(
                            onPressed: () async {
                              await updateDog(
                                int.parse(idController.text),
                                nameController.text,
                                int.parse(ageController.text),
                                context
                              );
                            },
                            child: const Text('Guardar'),
                          ),
                        ],
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
            ],
          ),
        )
      )
    );
  }
}