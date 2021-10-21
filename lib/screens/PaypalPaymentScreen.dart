import 'dart:core';
import 'package:bu_united_flutter_app/apiservices/PaypalServices.dart';
import 'package:bu_united_flutter_app/models/billing.dart';
import 'package:bu_united_flutter_app/models/shipping.dart';
import 'package:bu_united_flutter_app/models/woo/cart.dart';
import 'package:bu_united_flutter_app/screens/widgets/shipping_address_widget.dart';
import 'package:bu_united_flutter_app/utils/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaypalPayment extends StatefulWidget {
  final Function onFinish;
  // List<WooCartItems> items;
  Billing billing;
  MyWooCart cart;

  PaypalPayment({required this.onFinish , required this.cart , required this.billing});

  @override
  State<StatefulWidget> createState() {
    return PaypalPaymentState();
  }
}

class PaypalPaymentState extends State<PaypalPayment> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var checkoutUrl;
  var executeUrl;
  var accessToken ;
  PaypalServices services = PaypalServices();

  // you can change default currency according to your need
  Map<dynamic, dynamic> defaultCurrency = {
    "symbol": "USD ",
    "decimalDigits": 2,
    "symbolBeforeTheNumber": true,
    "currency": "USD"
  };

  bool isEnableShipping = false;
  bool isEnableAddress = false;

  String returnURL = 'https://example.com/return';
  String cancelURL = 'cancel.example.com';
  // String accessToken2 = 'A21AAKdq6RGi2X05KPkKroA4HCUvunWIdCebcUSORkumN-Cb0Vqs4uGxksn-CFcK4pt8twQs4kaxHltLcvjH6qjKYcwXoaWvQ';

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () async {
      try {
        accessToken = await services.getAccessToken();
        print("returned access token = " + accessToken);

        final transactions = getOrderParams();
        final res =
            await services.createPaypalPayment(transactions, accessToken);
        print(" returned res = " + res.toString());
        if (res != null) {
          setState(() {
            checkoutUrl = res["approvalUrl"];
            executeUrl = res["executeUrl"];
            print(" returned checkoutUrl = " + checkoutUrl.toString());
            print(" returned executeUrl = " + executeUrl.toString());
          });
        }
      } catch (e) {
        print('exception: ' + e.toString());
        final snackBar = SnackBar(
          content: Text(e.toString()),
          duration: Duration(seconds: 10),
          action: SnackBarAction(
            label: 'Close',
            onPressed: () {
              // Some code to undo the change.
              Navigator.pop(context);
            },
          ),
        );
        // ignore: deprecated_member_use
        _scaffoldKey.currentState!.showSnackBar(snackBar);
      }
    });
  }

  // item name, price and quantity
  String itemName = 'iPhone X';
  String itemPrice = '1.99';
  int quantity = 1;

  Map<String, dynamic> getOrderParams() {
    /*List items = [
      {
        "name": itemName,
        "quantity": quantity,
        "price": itemPrice,
        "currency": defaultCurrency["currency"]
      }
    ];*/
    // print(widget.cart.items[0].prices.)
    List items = widget.cart.items!.map((e) => {
      "name": e.name.toString(),
      "quantity": e.quantity.toString(),
      "price": e.prices!.price.toString()+".00",
      "currency": defaultCurrency["currency"]
    }).toList();

    // checkout invoice details
    String totalAmount = widget.cart.totals!.totalPrice+".00".toString();
    print(widget.cart.totals!.totalPrice+".00".toString());
    String subTotalAmount = widget.cart.totals!.totalPrice.toString();
    String shippingCost = widget.cart.totals!.totalShippingTax.toString();
    print(widget.cart.totals!.totalShippingTax.toString());
    int shippingDiscountCost = 0;
    String userFirstName = widget.billing.firstName.toString();
    print(widget.billing.firstName.toString());
    String userLastName = widget.billing.lastName.toString();
    print(widget.billing.lastName.toString());
    String addressCity = widget.billing.city.toString();
    print(widget.billing.city.toString());
    String addressStreet = widget.billing.address1.toString();
    print(widget.billing.address1.toString());
    String addressZipCode = widget.billing.postcode.toString();
    print(widget.billing.postcode.toString());
    String addressCountry = "Egypt";
    print(widget.billing!.country.toString());
    String addressState = widget.billing.state.toString();
    print(widget.billing!.state.toString());
    String addressPhoneNumber = widget.billing.phone.toString();
    print(widget.billing!.phone.toString());

    Map<String, dynamic> temp = {
      "intent": "sale",
      "payer": {"payment_method": "paypal"},
      "transactions": [
        {
          "amount": {
            "total": totalAmount,
            "currency": defaultCurrency["currency"],
            "details": {
              "subtotal": subTotalAmount,
              "shipping": shippingCost,
              "shipping_discount": "0"/*((-1.0) * shippingDiscountCost).toString()*/
            }
          },
          "description": "The payment transaction.",
          "payment_options": {
            "allowed_payment_method": "INSTANT_FUNDING_SOURCE"
          },
          "item_list": {
            "items": items,
            if (isEnableShipping && isEnableAddress)
              "shipping_address": {
                "recipient_name": userFirstName + " " + userLastName,
                "line1": addressStreet,
                "line2": "",
                "city": addressCity,
                "country_code": addressCountry,
                "postal_code": addressZipCode,
                "phone": addressPhoneNumber,
                "state": addressState
              },
          }
        }
      ],
      "note_to_payer": "Contact us for any questions on your order.",
      "redirect_urls": {"return_url": returnURL, "cancel_url": cancelURL}
    };
    return temp;
  }

  @override
  Widget build(BuildContext context) {
    print("BBBB : " + checkoutUrl.toString());

    if (checkoutUrl != null) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: appColorRed,
          leading: GestureDetector(
            child: Icon(Icons.arrow_back_ios),
            onTap: () => Navigator.pop(context),
          ),
        ),
        body: WebView(
          initialUrl: checkoutUrl,
          javascriptMode: JavascriptMode.unrestricted,
          navigationDelegate: (NavigationRequest request) {
            print(" returned request = " + request.toString());
            print(" returned request url = " + request.url.toString());
            if (request.url.contains(returnURL)) {
              final uri = Uri.parse(request.url);
              final payerID = uri.queryParameters['PayerID'];

              if (payerID != null) {
                services
                    .executePayment(executeUrl, payerID, accessToken)
                    .then((id) {
                  widget.onFinish(id);
                  // Navigator.of(context).pop();
                });
              } else {
                Navigator.of(context).pop();
              }
              Navigator.of(context).pop();
            }
            if (request.url.contains(cancelURL)) {
              Navigator.of(context).pop();
            }
            return NavigationDecision.navigate;
          },
        ),
      );
    } else {
      return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
              }),
          backgroundColor: Colors.black12,
          elevation: 0.0,
        ),
        body: Center(child: Container(child: CircularProgressIndicator())),
      );
    }
  }
}
