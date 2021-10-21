import 'dart:convert';
import 'dart:math';

import 'package:bu_united_flutter_app/controllers/auth_controller.dart';
import 'package:bu_united_flutter_app/models/woo/cart.dart';
import 'package:bu_united_flutter_app/utils/account.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CartService {

  Future<MyWooCart?> getMyCart(String userToken) async {
    Map<String, String> _urlHeader = {'Authorization': ''};
    //String userToken =
    // "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvYnUtdW5pdGVkLWludGVybmV0LmNvbSIsImlhdCI6MTYzMTk0MDY3MiwibmJmIjoxNjMxOTQwNjcyLCJleHAiOjE2MzI1NDU0NzIsImRhdGEiOnsidXNlciI6eyJpZCI6OSwiZGV2aWNlIjoiIiwicGFzcyI6ImJiZTVjOTU0MWQxOTVlOGFlZGZhOGQ2ZTU0NmZlZmQyIn19fQ.dsHvw2GyfdtK1l7PDR2q7KfBe8NqFTuBfNqDzk-idok
    // "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvYnUtdW5pdGVkLWludGVybmV0LmNvbSIsImlhdCI6MTYzMTk0MDMzOSwibmJmIjoxNjMxOTQwMzM5LCJleHAiOjE2MzI1NDUxMzksImRhdGEiOnsidXNlciI6eyJpZCI6OSwiZGV2aWNlIjoiIiwicGFzcyI6bnVsbH19fQ.xD9hjvtDw9PxfV2VZoUTqMx5pszMZVv7emZTf1BQuic
    // "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvd3d3LmJ1LXVuaXRlZC1pbnRlcm5ldC5jb20iLCJpYXQiOjE2MzA1MTIzMTMsIm5iZiI6MTYzMDUxMjMxMywiZXhwIjoxNjMxMTE3MTEzLCJkYXRhIjp7InVzZXIiOnsiaWQiOjM4LCJkZXZpY2UiOiIiLCJwYXNzIjoiOGQ2NmJmYWE5ZTQ2NTRmYWYxNDcwMWM2NzQ0ZTY5NDgifX19.ZVYm0kAB8jUfXkuEUKlxxSnaEuUmSgDQhHtGN57WOJA";;

    // "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvd3d3LmJ1LXVuaXRlZC1pbnRlcm5ldC5jb20iLCJpYXQiOjE2MzA4ODk3MTAsIm5iZiI6MTYzMDg4OTcxMCwiZXhwIjoxNjMxNDk0NTEwLCJkYXRhIjp7InVzZXIiOnsiaWQiOjUwLCJkZXZpY2UiOiIiLCJwYXNzIjoiODFiMzk4NjNmYmZiNTI0ZmE3ZTNkYWI3YmNkYTE0NTIifX19.2hgEBlUb0iXgKHuBq3mL4tgRdzSgxF_wsKhuqx5InrU";;
    print("eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvd3d3LmJ1LXVuaXRlZC1pbnRlcm5ldC5jb20iLCJpYXQiOjE2MzA4ODkzOTcsIm5iZiI6MTYzMDg4OTM5NywiZXhwIjoxNjMxNDk0MTk3LCJkYXRhIjp7InVzZXIiOnsiaWQiOjQ5LCJkZXZpY2UiOiIiLCJwYXNzIjpudWxsfX19.ZvwfIXldwyeZL0HioJgWjciLHFm-98CdOBO2e1kg91U".length.toString());
    print("eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvYnUtdW5pdGVkLWludGVybmV0LmNvbSIsImlhdCI6MTYzMTk0MDY3MiwibmJmIjoxNjMxOTQwNjcyLCJleHAiOjE2MzI1NDU0NzIsImRhdGEiOnsidXNlciI6eyJpZCI6OSwiZGV2aWNlIjoiIiwicGFzcyI6ImJiZTVjOTU0MWQxOTVlOGFlZGZhOGQ2ZTU0NmZlZmQyIn19fQ.dsHvw2GyfdtK1l7PDR2q7KfBe8NqFTuBfNqDzk-idok".length.toString());
    // "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvd3d3LmJ1LXVuaXRlZC1pbnRlcm5ldC5jb20iLCJpYXQiOjE2MzA4ODkzOTcsIm5iZiI6MTYzMDg4OTM5NywiZXhwIjoxNjMxNDk0MTk3LCJkYXRhIjp7InVzZXIiOnsiaWQiOjQ5LCJkZXZpY2UiOiIiLCJwYXNzIjpudWxsfX19.ZvwfIXldwyeZL0HioJgWjciLHFm-98CdOBO2e1kg91U";;
    // "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvd3d3LmJ1LXVuaXRlZC1pbnRlcm5ldC5jb20iLCJpYXQiOjE2MzA4ODk2MjYsIm5iZiI6MTYzMDg4OTYyNiwiZXhwIjoxNjMxNDk0NDI2LCJkYXRhIjp7InVzZXIiOnsiaWQiOjUwLCJkZXZpY2UiOiIiLCJwYXNzIjpudWxsfX19.IAWEcrHs60QpcwPX9j9CQHr2uKauGw-GlWEUa_N9sX8";;
    _urlHeader['Authorization'] = 'Bearer ' + userToken;
    MyWooCart cart;
    var url =
        Uri.parse("https://www.bu-united-internet.com/wp-json/wc/store/cart");
    final response = await http.get(url, headers: _urlHeader);
    print('response gotten body: ' + response.body.toString());
    print('response gotten body msg: ' +
        json.decode(response.body)['message'].toString());
    print('response gotten body totals: ' +
        json.decode(response.body)['totals'].toString());
    print('response gotten body items: ' +
        json.decode(response.body)['items'].toString());
    if (json.decode(response.body)['message'].toString() ==
        "Token is obsolete") {
      final auth = Get.put(AuthController());
      auth
          .customerLogin(
              emailOrUserName: auth.loggedInCustomer.value.email,
              password: account.pass,
              onFailed: (msg) {
                print("msg = " + msg.toString());
              })
          .then((customer) {
        account.customerId = customer!.id.toString() ;
        account.customerToken = customer.token.toString() ;
        print(account.customerId + " LOGGED IN AGAIN");
        print(account.customerToken + " LOGGED IN AGAIN");
      });
    }
    if (json.decode(response.body)['items'] == null) {
      print("items = null");
    }
    if (json.decode(response.body)['items'] == "[]") {
      print("items empty");
      return MyWooCart(items: []);
    }
    /*if(response == null){

    }*/
    if (response.statusCode >= 200 && response.statusCode < 300) {
      final jsonStr = json.decode(response.body);
      cart = MyWooCart.fromJson(jsonStr);
      //print("jsonStr = : " + jsonStr.toString());
      //print("response gotten CART total Price : " + cart.totals!.totalPrice.toString());
      int itemsCount = 0;
      // for( int i = 0 ; i < cart.items!.length ; i++){
      //   print("name : " + cart.items![i].name.toString());
      // }
      return cart;
    } else {
      print(' error : ' + response.body);
      // WooCommerceError err =
      // WooCommerceError.fromJson(json.decode(response.body));
      throw "err";
    }
  }


  Future<bool> addToMyCart(
      String userToken, String productId, String quantity) async {
    Random rand = Random();
    List<int> codeUnits = List.generate(10, (index) {
      return rand.nextInt(26) + 97;
    });

    /// Random string uniquely generated to identify each signed request
    String nonce = String.fromCharCodes(codeUnits);

    Map<String, String> _urlHeader = {
      'Authorization': '',
      'X-WC-Store-API-Nonce': nonce
    };
    // String userToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvd3d3LmJ1LXVuaXRlZC1pbnRlcm5ldC5jb20iLCJpYXQiOjE2MzA1MTIzMTMsIm5iZiI6MTYzMDUxMjMxMywiZXhwIjoxNjMxMTE3MTEzLCJkYXRhIjp7InVzZXIiOnsiaWQiOjM4LCJkZXZpY2UiOiIiLCJwYXNzIjoiOGQ2NmJmYWE5ZTQ2NTRmYWYxNDcwMWM2NzQ0ZTY5NDgifX19.ZVYm0kAB8jUfXkuEUKlxxSnaEuUmSgDQhHtGN57WOJA";
    // String userToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvd3d3LmJ1LXVuaXRlZC1pbnRlcm5ldC5jb20iLCJpYXQiOjE2MzA4ODYwMTcsIm5iZiI6MTYzMDg4NjAxNywiZXhwIjoxNjMxNDkwODE3LCJkYXRhIjp7InVzZXIiOnsiaWQiOjQ4LCJkZXZpY2UiOiIiLCJwYXNzIjpudWxsfX19.x5GaMOASbPeJSO_3W8okZS68siN9Sp_WmfOFswLLMl4";
    // String userToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvd3d3LmJ1LXVuaXRlZC1pbnRlcm5ldC5jb20iLCJpYXQiOjE2MzA4ODcyMzAsIm5iZiI6MTYzMDg4NzIzMCwiZXhwIjoxNjMxNDkyMDMwLCJkYXRhIjp7InVzZXIiOnsiaWQiOjQ4LCJkZXZpY2UiOiIiLCJwYXNzIjoiYzMwYTY5OGZjNGUxMDAwYzEwZDJhZmU4MjVlN2EyNzEifX19.d1VadzyhmdOhQOLkQy4KoB_P4c6japdFSxmONIo-Rdg";

    _urlHeader['Authorization'] = 'Bearer ' + userToken;
    MyWooCart cart;
    var url = Uri.parse(
        "https://www.bu-united-internet.com/wp-json/wc/store/cart/items");
    final response = await http.post(url, headers: _urlHeader, body: {
      'id': productId,
      'quantity': quantity,
    }).catchError((e) {
      print("//////////////////// ee = " + e.toString());
    }).then((value) {
      final jsonStr = json.decode(value.body);
      print("//////////////////// value = " + jsonStr.toString());
    });
    print('response gotten : ' + response.toString());
    return true;
  }

  Future<bool> editCartItem(
      String userToken, String itemKey, String quantity) async {
    Random rand = Random();
    List<int> codeUnits = List.generate(10, (index) {
      return rand.nextInt(26) + 97;
    });
    print("key = " + itemKey);
    print("quantity = " + quantity);

    /// Random string uniquely generated to identify each signed request
    String nonce = String.fromCharCodes(codeUnits);

    Map<String, String> _urlHeader = {
      'Authorization': '',
      'X-WC-Store-API-Nonce': nonce
    };
    // String userToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvd3d3LmJ1LXVuaXRlZC1pbnRlcm5ldC5jb20iLCJpYXQiOjE2MzA1MTIzMTMsIm5iZiI6MTYzMDUxMjMxMywiZXhwIjoxNjMxMTE3MTEzLCJkYXRhIjp7InVzZXIiOnsiaWQiOjM4LCJkZXZpY2UiOiIiLCJwYXNzIjoiOGQ2NmJmYWE5ZTQ2NTRmYWYxNDcwMWM2NzQ0ZTY5NDgifX19.ZVYm0kAB8jUfXkuEUKlxxSnaEuUmSgDQhHtGN57WOJA";
    _urlHeader['Authorization'] = 'Bearer ' + userToken;
    MyWooCart cart;
    var url = Uri.parse(
        "https://www.bu-united-internet.com/wp-json/wc/store/cart/update-item");
    final response = await http.post(url, headers: _urlHeader, body: {
      'key': itemKey,
      'quantity': quantity,
    }).catchError((e) {
      print("//////////////////// ee = " + e.toString());
    }).then((value) {
      final jsonStr = json.decode(value.body);
    });
    print('response gotten : ' + response.toString());

    return true;
  }

  Future<bool> deleteCartItem(String userToken, String itemKey) async {
    Random rand = Random();
    List<int> codeUnits = List.generate(10, (index) {
      return rand.nextInt(26) + 97;
    });

    /// Random string uniquely generated to identify each signed request
    String nonce = String.fromCharCodes(codeUnits);

    Map<String, String> _urlHeader = {
      'Authorization': '',
      'X-WC-Store-API-Nonce': nonce
    };
    // String userToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvd3d3LmJ1LXVuaXRlZC1pbnRlcm5ldC5jb20iLCJpYXQiOjE2MzA1MTIzMTMsIm5iZiI6MTYzMDUxMjMxMywiZXhwIjoxNjMxMTE3MTEzLCJkYXRhIjp7InVzZXIiOnsiaWQiOjM4LCJkZXZpY2UiOiIiLCJwYXNzIjoiOGQ2NmJmYWE5ZTQ2NTRmYWYxNDcwMWM2NzQ0ZTY5NDgifX19.ZVYm0kAB8jUfXkuEUKlxxSnaEuUmSgDQhHtGN57WOJA";
    _urlHeader['Authorization'] = 'Bearer ' + userToken;
    MyWooCart cart;
    var url = Uri.parse(
        "https://www.bu-united-internet.com/wp-json/wc/store/cart/remove-item");
    final response = await http.post(url, headers: _urlHeader, body: {
      'key': itemKey,
    }).catchError((e) {
      print("//////////////////// ee = " + e.toString());
    }).then((value) {
      final jsonStr = json.decode(value.body);

      print("//////////////////// value = " + jsonStr.toString());
    });
    print('response gotten : ' + response.toString());
    return true;
  }

}
