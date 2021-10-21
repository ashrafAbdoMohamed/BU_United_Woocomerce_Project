import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:bu_united_flutter_app/controllers/auth_controller.dart';
import 'package:bu_united_flutter_app/models/order.dart';
import 'package:bu_united_flutter_app/models/simple_order.dart';
import 'package:bu_united_flutter_app/models/woo/cart.dart';
import 'package:bu_united_flutter_app/utils/AppConstant.dart';
import 'package:bu_united_flutter_app/utils/account.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class OrderApiService {



  Future<Order?> createAnOrder(Order order) async {

    var url = Uri.parse(baseUrl + "orders?consumer_key=$consumer_key&consumer_secret=$consumer_secret");

    var response = await http.post(url,
        body: json.encode(order.toJson()),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json"
        });

    var jsonResults = jsonDecode(response.body) ;
    print("jsonResults //=// " + jsonResults.toString());
    return Order.fromJson(jsonResults);

  }

  Future<Order> getOrderByNumber(String orderNumber) async {
    var url = Uri.parse("https://bu-united-internet.com/api/get_order_by_number.php?order=$orderNumber");

    var response = await http.get(url,
        headers: {
          HttpHeaders.contentTypeHeader: "application/json"
        });

    String stringResults = response.body;
    print("jsonResults //Order Object// Whole" + stringResults.toString());

    List<String> splits = stringResults.split("#][#");

    List<LineItems> itemsList = [];
    for(int i = 0 ; i < splits.length-1 ; i++){ //-1 to avoid the last element which has the order object..
      List<String> itemsSplits = splits.elementAt(i).split("-][-");
      String productName = (itemsSplits.length > 1) ? itemsSplits[1] : ""; print("name = " + productName );
      String productID = (itemsSplits.length > 1) ? itemsSplits[2]: ""; print("name = " + productID );
      String productQuantity = (itemsSplits.length > 1) ? itemsSplits[3]: ""; print("name = " + productQuantity );
      String productTotalPrice = (itemsSplits.length > 1) ? itemsSplits[4]: ""; print("name = " + productTotalPrice );
      LineItems item = LineItems(id: productID.toString() , name: productName.toString() ,
       quantity: productQuantity.toString() , total: productTotalPrice.toString());
      itemsList.add(item);
    }
    var jsonResults = jsonDecode(splits.elementAt(splits.length-1));
    print("jsonResults //Order Object// " + jsonResults.toString());
    //return Order();
    return Order.fromJson(jsonResults , items: itemsList);
  }

  Future<List<SimpleOrder>?> getMyOrders(String email) async {
    var url = Uri.parse("https://bu-united-internet.com/api/get_customer_orders.php?email=$email");
    print("$email");
    var response = await http.get(url,
        headers: {
          HttpHeaders.contentTypeHeader: "application/json"
        });
    var jsonResults = jsonDecode(response.body) as List;
    print("jsonResults //My Order// " + jsonResults.toString());
    return  jsonResults.map((order) => SimpleOrder.fromJson(order)).toList();

  }



}
