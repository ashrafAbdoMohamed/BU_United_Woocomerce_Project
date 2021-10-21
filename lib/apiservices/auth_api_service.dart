import 'dart:convert';
import 'dart:io';
import 'package:bu_united_flutter_app/models/customer.dart';
import 'package:bu_united_flutter_app/utils/AppConstant.dart';
import 'package:http/http.dart' as http;

class AuthApiService {



  Future<Customer?> tryToCreateCustomers(Customer customer , Function function(msg)) async {
    var authToken = base64.encode(
      utf8.encode(consumer_key + ":" + consumer_secret),
    );
    var url = Uri.parse(baseUrl + customersUrl);
    var response = await http.post(
        url,
        body: jsonEncode(customer.toJson()),
        headers: {
          HttpHeaders.authorizationHeader: 'Basic $authToken',
          HttpHeaders.contentTypeHeader: "application/json"
        }
    );

    if(response.statusCode == 201){
      var jsonResults = json.decode(response.body);
      // print("registered jsonResults" + jsonResults);
      Customer insertedCustomer = Customer.fromJson(jsonResults);
      return insertedCustomer;
    }else{
      /*TODO: ERROR*/
      String errorMsg = json.decode(response.body)["message"].toString();
      errorMsg = errorMsg.split(".")[0].toString();
      print("errorMsg = " + errorMsg.split(".")[0].toString());
      function(errorMsg);
      return null;
    }


    print("WooCommerce body: " + response.body.toString());
    print("WooCommerce statusCode: " + response.statusCode.toString());

  }

  Future<Customer?> loginCustomer( String userName ,  String password ,  Function function(msg)) async {

    var url = Uri.parse(tokenUrl);
    var response = await http.post(
        url,
        body: {
          'username' : userName,
          'password' : password
        },
        headers: {
          HttpHeaders.contentTypeHeader: "application/x-www-form-urlencoded"
        }
    );

   /* print("WooCommerce body: " + response.body.toString());
    print("WooCommerce ddddd: " + json.decode(response.body)['data'].toString());
    print("WooCommerce token: " + json.decode(response.body)['data']['token'].toString());
    print("WooCommerce statusCode: " + response.statusCode.toString());
*/
    Customer? customer;
    if(response.statusCode == 200){
      /*TODO: SUCCESSFUL*/
      var jsonResults = json.decode(response.body);
      var data = jsonResults['data'];
      print("WooCommerce data: " + data.toString());
      customer = Customer.fromJson(data);
      return customer;
    }else{
      /*TODO: ERROR*/
      String errorMsg = json.decode(response.body)["message"].toString();
      errorMsg = errorMsg.split(".")[0].toString();
      print("errorMsg = " + errorMsg.split(".")[0].toString());
      function(errorMsg);
      return null;
    }

  }

  Future<String?> resetPassword( String email ) async {

    var url = Uri.parse(updatePassUrl+"?login=$email");
    var response = await http.get( url);

    print("response = " + response.toString());

    if(response.statusCode == 200){
      /*TODO: SUCCESSFUL*/
      var jsonResults = json.decode(response.body);
      var msg = jsonResults['msg'];
      print("WooCommerce msg: " + msg.toString());

      return msg;
    }else{
      /*TODO: ERROR*/
      // function("error has occurred, please try again");
      return "error has occurred, please try again";
      // return null;
    }

  }

  Future<String?> sendPasswordViaMail(String email , String generatedPass/*, Function function(msg)*/) async {

    var url = Uri.parse(sendPassUrl+"?login=$email&pass=$generatedPass");
    var response = await http.get( url);

    print("response = " + response.toString());

    if(response.statusCode == 200){
      /*TODO: SUCCESSFUL*/
      var jsonResults = json.decode(response.body);
      var msg = jsonResults['msg'];
      print("WooCommerce msg: " + msg.toString());

      return msg;
    }else{
      /*TODO: ERROR*/
      // function("error has occurred, please try again");
      return "error has occurred, please try again";
      // return null;
    }

  }



  /*Future<Customer?> customerLogin(String emailOrUserName , String password) async {

    var url = Uri.parse(baseUrl + "select_admins");
    var response = await http.post(url, body: {
      "phone": phone,
      "pass": password,
    });
    var jsonResults = jsonDecode(response.body);
    print("jsonResults = " + jsonResults.toString());
    Teacher? mTeacher;
    if((jsonResults['response']['data']) != [] ){
      if (jsonResults['response']['data'][0] != null) {
        var data = jsonResults['response']['data'][0];
        mTeacher = Teacher.fromJson(data);
      }
    }
    // print("mStudent = " +mStudent?.name);
    return mTeacher;
    //return mStudent;
  }*/

}
