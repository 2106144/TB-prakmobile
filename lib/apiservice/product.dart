import 'package:bakeryapps/models/product.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

class ProductApi {
  final String baseUrl = "https://api.kartel.dev";

  Future<List<Product>> getProducts() async {
    final response = await http.get(Uri.parse('$baseUrl/products'));
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<Product> products =
          body.map((dynamic item) => Product.fromJson(item)).toList();
      return products;
    } else {
      throw "Failed to load products";
    }
  }

  Future<bool> createProduct(
    String nama,
    double price,
    double qty,
    String attr,
    double weight,
  ) async {
    final response = await http.post(
      Uri.parse('$baseUrl/products'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "name": nama,
        "price": price,
        "qty": qty,
        "attr": attr,
        "weight": weight,
      }),
    );
    var data = jsonDecode(response.body);
    print(data);

    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateProduct(Product product, String id) async {
    final response = await http.put(
      Uri.parse('$baseUrl/products/$id'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "name": product.name,
        "price": product.price,
        "qty": product.qty,
        "attr": product.attr,
        "weight": product.weight,
      }),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteProduct(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/products/$id'));
    if (response.statusCode == 204) {
      return true;
    } else {
      return false;
    }
  }
}
