import 'dart:async';
import 'dart:convert';

import 'package:bu_united_flutter_app/models/customer.dart';
import 'package:shared_preferences/shared_preferences.dart';

final Account account = Account._private();

class Account {

  late SharedPreferences _prefs;
  late Future<SharedPreferences> prefsFuture;

  String get language => _prefs.getString('language') ?? "ar";
  set language(field) => _prefs.setString('language', field);

 /* Customer get customer => (_prefs.get("customer") == null ) ? Customer(email: "-1") :
    Customer.fromJson(jsonDecode(_prefs.get("customer") as String))  ;
  set customer(customer) => _prefs.setString("customer" , jsonEncode(customer));*/

  String get customerId => _prefs.getString("customerId") ?? "-1" ;
  set customerId(customerId) => _prefs.setString("customerId" , customerId);

  String get customerToken => _prefs.getString("customerToken") ?? "-1" ;
  set customerToken(customerToken) => _prefs.setString("customerToken" , customerToken);

  String get pass => _prefs.getString("pass") ?? "-1" ;
  set pass(pass) => _prefs.setString("pass" , pass);

  List<String> get orders => _prefs.getStringList("orders") ?? [] ;
  set orders(orders) => _prefs.getStringList("orders" );

  clear() {
    _prefs.clear();
  }

  Account._private() {
    getPreferencesFuture();
    getPreferences();
  }

  void getPreferencesFuture() {
    prefsFuture = SharedPreferences.getInstance();
  }

  Future<void> getPreferences() async {
    _prefs = await SharedPreferences.getInstance();
  }
}
