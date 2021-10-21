import 'dart:convert';
import 'dart:io';
import 'package:bu_united_flutter_app/models/customer.dart';
import 'package:bu_united_flutter_app/utils/AppConstant.dart';
import 'package:http/http.dart' as http;

class CustomerService {


  Future<List<Customer?>?> getAllCustomers() async {
    var url = Uri.parse(baseUrl + "customers?consumer_key=$consumer_key&consumer_secret=$consumer_secret");
    var respond = await http.get(url);

    var jsonResults = jsonDecode(respond.body) as List;
    print("jsonResults = " + jsonResults.toString());
    //List<Customer>? mCustomers;
    return jsonResults.map((customer) => Customer.fromJson(customer)).toList();
  }

  Future<Customer?> getCustomer(String id) async {
    var url = Uri.parse(baseUrl + "customers/$id?consumer_key=$consumer_key&consumer_secret=$consumer_secret");
    var respond = await http.get(url);

    var jsonResults = jsonDecode(respond.body) ;
    print("jsonResults = " + jsonResults.toString());
    return Customer.fromJson(jsonResults);
  }

  Future<Customer?> updateCustomerInfo(Customer customer) async {
    var url = Uri.parse(baseUrl + "customers/${customer.id}?consumer_key=$consumer_key&consumer_secret=$consumer_secret");
    var respond = await http.put(url ,
        body: json.encode({
          "first_name": customer.firstName ??"",
          "last_name": customer.lastName??"",
        } ),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json"
        } ,);

    var jsonResults = jsonDecode(respond.body) ;
    print("jsonResults body = " + jsonResults.toString());
    print("jsonResults status = " + respond.statusCode.toString());
    return Customer.fromJson(jsonResults);
  }

  Future<Customer?> updateCustomerShipping(Customer customer) async {
    var url = Uri.parse(baseUrl + "customers/${customer.id}?consumer_key=$consumer_key&consumer_secret=$consumer_secret");
    var respond = await http.put(url ,
        body: json.encode({
          "shipping": {
            "first_name": customer.shipping!.firstName??"",
            "last_name": customer.shipping!.lastName??"",
            "company": customer.shipping!.company??"",
            "address_1": customer.shipping!.address1??"",
            "address_2": customer.shipping!.address2??"",
            "city": customer.shipping!.city??"",
            "state": customer.shipping!.state??"",
            "postcode": customer.shipping!.postcode??"",
            "country": customer.shipping!.country??""
          },

        } ),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json"
        } ,);

    var jsonResults = jsonDecode(respond.body) ;
    print("jsonResults body = " + jsonResults.toString());
    print("jsonResults status = " + respond.statusCode.toString());
    return Customer.fromJson(jsonResults);
  }

  Future<Customer?> updateCustomerBilling(Customer customer) async {
    var url = Uri.parse(baseUrl + "customers/${customer.id}?consumer_key=$consumer_key&consumer_secret=$consumer_secret");
    var respond = await http.put(url ,
      body: (customer.billing!.email.toString().isNotEmpty) ? json.encode({
        "billing": {
          "first_name": customer.billing!.firstName??"",
          "last_name": customer.billing!.lastName??"",
          "company": customer.billing!.company??"",
          "address_1": customer.billing!.address1??"",
          "address_2": customer.billing!.address2??"",
          "city": customer.billing!.city??"",
          "state": customer.billing!.state??"",
          "postcode": customer.billing!.postcode??"",
          "country": customer.billing!.country??"",
          "email": customer.billing!.email??"",
          "phone": customer.billing!.phone ??""
        },
      } )
      : json.encode({
          "billing": {
          "first_name": customer.billing!.firstName??"",
          "last_name": customer.billing!.lastName??"",
          "company": customer.billing!.company??"",
          "address_1": customer.billing!.address1??"",
          "address_2": customer.billing!.address2??"",
          "city": customer.billing!.city??"",
          "state": customer.billing!.state??"",
          "postcode": customer.billing!.postcode??"",
          "country": customer.billing!.country??"",
          "phone": customer.billing!.phone ??""
          },}

      ),
      headers: {
        HttpHeaders.contentTypeHeader: "application/json"
      } ,);

    var jsonResults = jsonDecode(respond.body) ;
    print("jsonResults body = " + jsonResults.toString());
    print("jsonResults status = " + respond.statusCode.toString());
    return Customer.fromJson(jsonResults);
  }

}
