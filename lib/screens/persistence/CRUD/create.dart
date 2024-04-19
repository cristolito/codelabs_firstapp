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

Future<void> insertDog(String name, int age, BuildContext context) async {
  final db = await initializeDatabase();

  // Query the last ID from the table
  final List<Map<String, dynamic>> result = await db.rawQuery('SELECT MAX(id) as lastId FROM dogs');
  int lastId = result.first['lastId'] as int? ?? 0;
  // Generate a new ID
  final int newId = lastId + 1;

  Dog dog = Dog(id: newId, name: name, age: age);
  await db.insert(
    'dogs',
    dog.toMap(),
  );
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('Dog inserted successfully!'),
    ),
  );
  name = '';
}

class CreatePage extends StatefulWidget {
  const CreatePage({super.key});

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  late Future<Database> database;
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
      appBar: AppBar(title: Text('Insert into table dogs')),
      body: SingleChildScrollView(
        child: Form(
          child: Column(
            children: <Widget>[

              
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text('Dog name:'),
                ],
              ),
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  hintText: 'Write a name',
                  hintStyle: TextStyle(color: Color.fromARGB(255, 182, 182, 182)) ,
                ),
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Write a name.';
                  }
                  return null;
                },
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text('Dog age:'),
                ],
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: ageController,
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  hintText: 'Write a number',
                  hintStyle: TextStyle(color: Color.fromARGB(255, 182, 182, 182)) ,
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
                  await insertDog(
                    nameController.text,
                    int.parse(ageController.text),
                    context
                  );
                } , 
                child: const Text('Guardar'),
              ),
            ],
          ),
        )
      )
    );
  }
}