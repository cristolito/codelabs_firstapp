// lib/screens/form_page.dart
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Product {
  //final int userId;
  final String productName;
  final int unitPrice;
  final String labels;

  const Product({
    //required this.userId,
    required this.productName,
    required this.unitPrice,
    required this.labels,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productName: json['productName'] as String,
      unitPrice: json['unitPrice'] as int,
      labels: json['labels'] as String,
    );
  }
}

Future<Product> createProduct(String productName, String unitPrice, String labels) async {
  final response = await http.post(
    Uri.parse('https://lookgeniusapicliente.somee.com/api/boutique/1/product/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'productName': productName,
      'unitPrice': unitPrice,
      'labels': labels,
    }),

  );

  if (response.statusCode == 201) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    final dynamic jsonBody = jsonDecode(response.body);

    if (jsonBody is Map<String, dynamic>) {
      return Product.fromJson(jsonBody);
    } else {
      throw Exception('Invalid JSON format');
    }
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    if (response.statusCode == 400) {
      throw Exception('Bad request: Invalid data sent to the server.');
    } else {
      throw Exception('Failed to create a Product. Status Code: ${response.statusCode}');
    }
  }
}


// Define a custom Form widget.
class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  MyCustomFormState createState() => MyCustomFormState();

}

class MyCustomFormState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();
  final FocusNode _myFocusNode = FocusNode();
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final labelsController = TextEditingController();
  Future<Product>? futureProduct;
  

  void _printLatestValue() {
  final text = nameController.text;
  print('First text field: $text (${text.characters.length})');
  }

  @override
  void initState() {
    super.initState();
    nameController.addListener(_printLatestValue);
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    _myFocusNode.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const appTitle = 'post: 1 producto de 1 boutique';
    // Build a Form widget using the _formKey created above.
    return Scaffold(
      appBar: AppBar(
        title: Text(appTitle),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text('Nombre del producto:'),
                ],
              ),
              TextFormField(
                autofocus: true,
                focusNode: _myFocusNode,
                onChanged: (text) {
                  print('Primer campo mide: $text (${text.characters.length})');
                },
                controller: nameController,
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  hintText: 'Pantalón',
                  hintStyle: TextStyle(color: Color.fromARGB(255, 182, 182, 182)) ,
                ),
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, escribe algo.';
                  }
                  return null;
                },
              ),
              Row(
                children: [
                  Text('Precio:'),
                ],
              ),
              TextFormField(
                controller: priceController,
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  hintText: '150.00',
                  hintStyle: TextStyle(color: Color.fromARGB(255, 182, 182, 182)) ,
                ),
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, escribe algo.';
                  }
                  return null;
                },
              ),
              Row(
                children: [
                  Text('Etiquetas del producto:'),
                ],
              ),
              TextFormField(
                controller: labelsController,
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  hintText: 'Verano, Mezclilla...',
                  hintStyle: TextStyle(color: Color.fromARGB(255, 182, 182, 182)) ,
                ),
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, escribe algo.';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      futureProduct = createProduct(
                        nameController.text,
                        priceController.text,
                        labelsController.text
                      );
                    });
                  }
                },
                child: const Text('Guardar'),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () => _myFocusNode.requestFocus(),
            tooltip: 'Escribir (focus) en el primer campo',
            child: const Icon(Icons.edit),
          ),
          SizedBox(height: 16),
          FloatingActionButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: Text(nameController.text),
                  );
                },
              );
            },
            tooltip: 'Show me the value!',
            child: const Icon(Icons.text_fields),
          ),
        ],
      ),
    );
  }
}
