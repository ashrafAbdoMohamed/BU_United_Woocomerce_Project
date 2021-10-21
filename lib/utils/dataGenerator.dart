
import 'dart:convert';

import 'package:bu_united_flutter_app/models/product_category.dart';
import 'package:bu_united_flutter_app/models/Product.dart';
import 'package:flutter/services.dart';

Future<String> loadContentAsset(String path) async {
  return await rootBundle.loadString(path);
}

Future<List<ProductCategory>> loadCategory() async {
  String jsonString = await loadContentAsset('assets/data/category.json');
  final jsonResponse = json.decode(jsonString);
  print("JSON = " + jsonResponse.toString());
  return (jsonResponse as List).map((i) => ProductCategory.fromJson(i)).toList();
}

Future<List<Product>> loadProducts() async {
  String jsonString = await loadContentAsset('assets/data/products.json');
  final jsonResponse = json.decode(jsonString);
  print("JSON 2 = " + jsonResponse.toString());
  return (jsonResponse as List).map((i) => Product.fromJson(i)).toList();
}