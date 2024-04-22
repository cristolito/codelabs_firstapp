import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Product> fetchOneProduct(int productId) async {
  final response = await http.get(
    Uri.parse('https://lookgeniusapicliente.somee.com/api/boutique/1/product/$productId'),
  );

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Product.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load product');
  }
}

Future<Product> updateProduct(String productName, String unitPrice, String labels) async {
  final response = await http.put(
    Uri.parse('https://lookgeniusapicliente.somee.com/api/boutique/1/product/7'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'productName': productName,
      'unitPrice': unitPrice,
      'labels': labels,
    }),
  );

  if (response.statusCode == 204) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Product(
      productName: productName,
      unitPrice: double.parse(unitPrice),
      labels: labels,
    );
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to update Product.');
  }
}

class Product {
  //final int userId;
  final String productName;
  final double unitPrice;
  final String labels;

  const Product({
    required this.productName,
    required this.unitPrice,
    required this.labels,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productName: json['productName'] as String,
      unitPrice: json['unitPrice'] as double,
      labels: json['labels'] as String,
    );
  }
}

class UpdatePage extends StatefulWidget {
  const UpdatePage({super.key});

  @override
  State<UpdatePage> createState() {
    return _MyAppState();
    
  }
}

class _MyAppState extends State<UpdatePage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController labelsController = TextEditingController();
  late Future<Product> futureProduct;
  TextEditingController productIdController = TextEditingController();

  @override
  void initState() {
    super.initState();
    futureProduct = Future.value(Product(
      productName: '',
      unitPrice: 0.00,
      labels: '',
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Actualiza 1 producto, de 1 boutique'),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                controller: productIdController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Ingrese Id del producto'),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  int productId = int.tryParse(productIdController.text) ?? 0;
                  if (productId > 0) {
                    setState(() {
                      futureProduct = fetchOneProduct(productId);
                    });
                  } else {
                    print('Invalid Product ID');
                  }
                },
                child: Text('Buscar producto'),
              ),
              SizedBox(height: 16),
              FutureBuilder<Product>(
                future: futureProduct,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      nameController.text = snapshot.data!.productName;
                      priceController.text = snapshot.data!.unitPrice.toString();
                      labelsController.text = snapshot.data!.labels;
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text('${snapshot.data!.productName} \n${snapshot.data!.unitPrice} \n${snapshot.data!.labels}',
                          textAlign: TextAlign.center,
                          ),
                          TextField(
                            controller: nameController,
                            decoration: InputDecoration(
                              hintText: 'Nombre de producto',
                            ),
                          ),
                          TextField(
                            controller: priceController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              hintText: 'Precio de producto',
                            ),
                          ),
                          TextField(
                            controller: labelsController,
                            decoration: InputDecoration(
                              hintText: 'Etiquetas del producto',
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                futureProduct = updateProduct(
                                  nameController.text,
                                  priceController.text,
                                  labelsController.text
                                  );
                              });
                            },
                            child: const Text('Actualizar info'),
                          ),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    }
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