import 'package:flutter/material.dart';

class Sqlite extends StatefulWidget {
  const Sqlite({super.key});

  @override
  State<Sqlite> createState() => SqliteState();
}

class SqliteState extends State<Sqlite> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SQLite')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/persistence/CRUD/read');
              }, 
              child: Text('Read a table on the BD')),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/persistence/CRUD/create');
              },  
              child: Text('Create in a table on the BD')),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/persistence/CRUD/update');
              },  
              child: Text('Update in a table on the BD')),
            SizedBox(height: 40),ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/persistence/CRUD/delete');
              },  
              child: Text('Delete in a table on the BD')),
          ]
        ),
    );
  }
}