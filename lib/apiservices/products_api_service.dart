import 'dart:convert';
import 'dart:io';
import 'package:bu_united_flutter_app/models/Product.dart';
import 'package:bu_united_flutter_app/models/customer.dart';
import 'package:bu_united_flutter_app/models/product_category.dart';
import 'package:bu_united_flutter_app/utils/AppConstant.dart';
import 'package:http/http.dart' as http;
import 'package:nb_utils/nb_utils.dart';

class ProductsApiService {


  Future<List<ProductCategory?>?> getAllCategories() async {
    var url = Uri.parse(baseUrl + "products/categories?consumer_key=$consumer_key&consumer_secret=$consumer_secret");
    var respond = await http.get(url);

    var jsonResults = jsonDecode(respond.body) as List;
    print("jsonResults Cat = " + jsonResults.toString());
    //List<Customer>? mCustomers;
    return jsonResults.map((category) => ProductCategory.fromJson(category)).toList();
  }

  Future<List<Product?>?> getAllProducts() async {
    var url = Uri.parse(baseUrl + "products?consumer_key=$consumer_key&consumer_secret=$consumer_secret");
    var respond = await http.get(url);

    var jsonResults = jsonDecode(respond.body) as List;
    print("jsonResults Pro = " + jsonResults.toString());
    //List<Customer>? mCustomers;
    return jsonResults.map((product) => Product.fromJson(product)).toList();
  }



}
