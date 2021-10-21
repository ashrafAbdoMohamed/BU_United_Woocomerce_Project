import 'dart:convert';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert' as convert;

class PaypalServices {
  String domain = "https://api-m.sandbox.paypal.com"; // for sandbox mode
  // String domain = "https://api.sandbox.paypal.com"; // for sandbox mode
//  String domain = "https://api.paypal.com"; // for production mode

  // change clientId and secret with your own, provided by paypal
  //todo: ashrefabdo150 bu_test account credentials..
  String clientId =
      'AfJU5VuQpkkzeENz7DyxR7w4jR0aVd8N1IpaSPEoeibM7Hidt425qnpuLBC7RiEgBpRBYQkOjYaIi6Wg';
  String secret =
      'EKwtp7v3XiqoCgCDuYjr272LDPUgOSCAj9E9X9DfHAe9KZ_GTcF_de_Hr-weM7KNHZvzQ24b5Ujmk0OT';

  // for getting the access token from Paypal
  Future<String> getAccessToken() async {
    //todo: adrien account "BTest" account credentials..
    String username =
        'Ae_lZoMgtwdY6Mtbq-5eimOdXBnlKPqgt3ZOQFZNO75uDUYL1b7nPRhiMQG9_VtlMyzpBr1DmGiO5kP3';
    String password =
        'EDB0OH1dPlw3ubCegUj0_7WZhX-OuFTvQhZionPaVAKyu8sKqjhtRgdreuY2CiIIgn9FIM_uRxqXq9Hh';
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));

    print("res 0 ");
    try {
      // var client = BasicAuthClient(clientId, secret);
      print("res 0 0000");
      var response = await http.post(
              Uri.parse(
                '$domain/v1/oauth2/token?grant_type=client_credentials',
              ),
/*              body: jsonEncode({
                "grant_type":"client_credentials"
              }),*/
              headers: <String, String>{
            'authorization': basicAuth,
            "Content-Type": "application/x-www-form-urlencoded"
          })
          .then((value) {
        print("value = " + value.toString());
        print("value.body = " + value.body.toString());

        if (value.statusCode == 200) {
          print("a");
          final body = convert.jsonDecode(value.body);
          print("b " + body.toString());
          print("b " + body["access_token"].toString());
          return body["access_token"].toString();
        }
      }).catchError((e) {
        print("erro = " + e.toString());
      }).whenComplete(() {
        print("completed");
      });
      print("res 1 = " + response.toString());
      return response.toString();

      // return "0";
    } catch (e) {
      rethrow;
    }
  }

  // for creating the payment request with Paypal
  Future<Map<String, String>> createPaypalPayment(transactions, accessToken) async {
    try {
      var response = await http.post(Uri.parse("$domain/v1/payments/payment"),
          body: convert.jsonEncode(transactions),
          headers: {
            "content-type": "application/json",
            'Authorization': 'Bearer ' + accessToken
          });

      final body = convert.jsonDecode(response.body);
      print("returned Body = " + response.body.toString());
      if (response.statusCode == 201) {
        if (body["links"] != null && body["links"].length > 0) {
          List links = body["links"];

          String executeUrl = "";
          String approvalUrl = "";
          final item = links.firstWhere((o) => o["rel"] == "approval_url",
              orElse: () => null);
          if (item != null) {
            approvalUrl = item["href"];
          }
          final item1 = links.firstWhere((o) => o["rel"] == "execute",
              orElse: () => null);
          if (item1 != null) {
            executeUrl = item1["href"];
          }
          return {"executeUrl": executeUrl, "approvalUrl": approvalUrl};
        }
        throw Exception("0");
      } else {
        throw Exception(body["message"]);
      }
    } catch (e) {
      rethrow;
    }
  }

  // for executing the payment transaction
  Future<String> executePayment(url, payerId, accessToken) async {
    try {
      var response = await http.post(Uri.parse(url),
          body: convert.jsonEncode({"payer_id": payerId}),
          headers: {
            "content-type": "application/json",
            'Authorization': 'Bearer ' + accessToken
          });
      print("JJ " + jsonDecode(response.body).toString());
      final body = convert.jsonDecode(response.body);
      print("JJ 2 " + body.toString());
      if (response.statusCode == 200) {
        return body["id"];
      }
      return "0";
    } catch (e) {
      rethrow;
    }
  }
}
