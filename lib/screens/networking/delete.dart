import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Product> fetchOneProduct(int productId) async {
  final response = await http.get(
    Uri.parse('https://lookgeniusapicliente.somee.com/api/boutique/1/product/$productId'),
    headers: {
      HttpHeaders.authorizationHeader: 'Basic your_api_token_here',
    },
  );

  if (response.statusCode == 200) {
    return Product.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Failed to load product');
  }
}

Future<http.Response> deleteOneProduct(int productId) async {
  final http.Response response = await http.delete(
    Uri.parse('https://lookgeniusapicliente.somee.com/api/boutique/1/product/$productId'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );

  return response;
}


class Product {
  //final int userId;
  final String productName;
  final double unitPrice;
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
      unitPrice: json['unitPrice'] as double,
      labels: json['labels'] as String,
    );
  }
}


class Delete extends StatefulWidget {
  const Delete({super.key});

  @override
  State<Delete> createState() => _MyAppState();
}

class _MyAppState extends State<Delete> {
  late Future<Product> futureProduct;
  TextEditingController productIdController = TextEditingController();

  @override
  void initState() {
    super.initState();
    futureProduct = Future.value(Product(
      productName: '',
      unitPrice: 0.0,
      labels: '',
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('delete: 1 producto de 1 boutique'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
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
                    // Show an error message or handle invalid input
                    print('Invalid Product ID');
                  }
                },
                child: Text('Buscar producto'),
              ),
              SizedBox(height: 16),
              FutureBuilder<Product>(
                future: futureProduct,
                builder: (context, snapshot){
                  if (snapshot.hasData) {
                    return Text(
                      'Product ID: ${productIdController.text}\n'
                      'Product Name: ${snapshot.data!.productName}\n'
                      'Unit Price: ${snapshot.data!.unitPrice}\n'
                      'Labels: ${snapshot.data!.labels}',
                    );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                  // By default, show a loading spinner.
                  return const CircularProgressIndicator();
                },
              ),
              Row(children: [Text(' ')],),
              ElevatedButton(
                onPressed: () {
                  int productId = int.tryParse(productIdController.text) ?? 0;
                  if (productId > 0) {
                    setState(() {
                      deleteOneProduct(productId);
                    });
                  } else {
                    // Show an error message or handle invalid input
                    print('Invalid Product ID/del');
                  }
                },
                child: Text('Borrar producto'),
              ),
            ],
          ),
        ),
      );
  }
}