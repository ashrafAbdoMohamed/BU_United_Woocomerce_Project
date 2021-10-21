import 'package:bu_united_flutter_app/controllers/cart_controller.dart';
import 'package:bu_united_flutter_app/controllers/order_controller.dart';
import 'package:bu_united_flutter_app/models/billing.dart';
import 'package:bu_united_flutter_app/models/order.dart';
import 'package:bu_united_flutter_app/models/shipping.dart';
import 'package:bu_united_flutter_app/models/woo/cart.dart';
import 'package:bu_united_flutter_app/screens/OrdersListScreen.dart';
import 'package:bu_united_flutter_app/utils/AppColors.dart';
import 'package:bu_united_flutter_app/utils/AppConstant.dart';
import 'package:bu_united_flutter_app/utils/AppImages.dart';
import 'package:bu_united_flutter_app/utils/AppWidget.dart';
import 'package:bu_united_flutter_app/utils/account.dart';
import 'package:bu_united_flutter_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:url_launcher/url_launcher.dart';

import 'PaypalPaymentScreen.dart';

class PaymentScreen extends StatefulWidget {
  Billing? billing;
  Shipping? shipping;

  PaymentScreen({this.billing, this.shipping});

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final cartController = Get.put(CartController());
  final orderController = Get.put(OrderController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (cartController.myCart.value.items!.isEmpty) {
      cartController.getMyCart(account.customerToken);
    }
  }

  @override
  Widget build(BuildContext context) {
    print(account.customerToken);
    return Obx(
      () => (cartController.isLoading.value)
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 16),
                    child: text("My Order",
                        fontSize: 26.0, textColor: appColorWhite, isBold: true),
                    alignment: Alignment.centerLeft,
                  ),
                  ProductsInOrder(cartController.myCart.value.items),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        text("Total price",
                            fontSize: 26.0, textColor: appColorWhite, isBold: true),
                        text(
                            cartController.myCart.value.totals!.totalPrice
                                .toString()
                                .toCurrencyFormat(),
                            fontSize: 26.0,
                            textColor: appColorRed,
                            isBold: true)
                      ],
                    ),
                  ),
                  10.height,
                  Container(
                    padding: EdgeInsets.only(left: 16),
                    child: text("Payment",
                        fontSize: 26.0 ,textColor: appColorWhite, isBold: true),
                    alignment: Alignment.centerLeft,
                  ),
                  paymentContainer(context),
                  20.height,
                  //too: Place Order Button
                  Obx(
                    () => (orderController.isLoading.value)
                        ? Center(child: CircularProgressIndicator())
                        : appSmallButton(
                            label: "Place Order",
                            btnWidth: MediaQuery.of(context).size.width - 30,
                            onTap: () {
                              if(_chosenValue == SingingCharacter.paypal){
                                //todo: pay with PayPal:
                                payWithPayPal();
                              }else{
                                //todo: pay cash:
                                payCash();
                              }
                            }),
                  ),
                  20.height,
                ],
              ),
            ),
    );
  }

  payWithPayPal(){
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => PaypalPayment(
          billing: widget.billing!,
          cart: cartController.myCart.value,
          onFinish: (number) async {
            // payment done
            print('order id: ' + number);
            if(number != null) {
              Future.delayed(Duration(seconds: 1), (){
                //showLoaderDialog(context);
                List<LineItems> lineItems = cartItemsToLineItems(
                    cartController.myCart.value.items);
                orderController.createAnOrder(
                  Order(
                    lineItems: lineItems,
                    status: "processing",
                    parentId: account.customerId,
                    paymentMethod: "paypal",
                    paymentMethodTitle: "PayPal",
                    billing: widget.billing,
                    shipping: widget.shipping,
                  ),
                ).then((order) async {
                  if (order != null) {
                    // snackBar(context, title: "Congratulations!!",
                    //     behavior: SnackBarBehavior.floating);
                    deleteAllItemsInCart();
                  }
                });
              });

            }
          },
        ),
      ),
    );
  }

  void payCash() {
    showConfirmDialog(
        context, "Are you sure you want to proceed?",
        onAccept: () {
          showLoaderDialog(context);
          List<LineItems> lineItems = cartItemsToLineItems( cartController.myCart.value.items);
          orderController .createAnOrder(
            Order(
              lineItems: lineItems,
              status: "processing",
              parentId: account.customerId,
              paymentMethod: "bacs",
              paymentMethodTitle: "Cash on delivery",
              billing: widget.billing,
              shipping: widget.shipping,
            ),
          ).then((order) async {
            if (order != null) {
              snackBar(context, title: "Congratulations!!", behavior: SnackBarBehavior.floating);
              deleteAllItemsInCart();
            }
          });
        });
  }

  deleteAllItemsInCart() async {
    //todo: delete all items in cart
    for (int i = 0;
    i <
        cartController
            .myCart.value.items!.length;
    i++) {
      await cartController
          .deleteCartItem(
          account.customerToken,
          cartController.myCart.value.items!
              .elementAt(i)
              .key)
          .then((value) {
        if (value == true) {
          print(" deleted item key: " +
              cartController.myCart.value.items!
                  .elementAt(i)
                  .key);
          cartController
              .getMyCart(account.customerToken)
              .then((value) {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
            goToPage( context, OrdersListScreen() );
          });
        }
      });
    }
  }

  String _mValue = "a";
  SingingCharacter? _chosenValue = SingingCharacter.paypal;

  Widget paymentContainer(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        width: width,
        height: 200,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          color: darkGrey.withOpacity(0.2) /*backgroundColor*/,
          elevation: 5,
          child: InkWell(
            highlightColor: grey.withOpacity(0.2),
            overlayColor:
                MaterialStateProperty.all(Colors.grey /*.withOpacity(0.1)*/),
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  10.height,
                  ListTile(
                    trailing: Container(
                      color: Colors.transparent,
                      child: Image.asset(
                        cash_icon,
                        width: 40,
                        height: 40,
                      ),
                    ),
                    title: text("Cash on delivery",
                        textColor: appColorWhite, isBold: true),
                    subtitle: text("Pay with cash upon delivery.",
                        textColor: appColorWhite, fontSize: 14.0),
                    leading: Radio<SingingCharacter>(
                      overlayColor: MaterialStateProperty.all(appColorRed),
                      activeColor: appColorRed,
                      fillColor: MaterialStateProperty.all(appColorRed),
                      // focusColor: appColorRed,
                      value: SingingCharacter.cash,
                      groupValue: _chosenValue,
                      onChanged: (SingingCharacter? value) {
                        setState(() {
                          _chosenValue = value;
                          print("_chosenValue " + _chosenValue.toString());
                        });
                      },
                    ),
                  ),
                  ListTile(
                    trailing: Container(
                      color: Colors.white.withOpacity(0.9),
                      child: Image.asset(
                        paypal_icon,
                        width: 60,
                        height: 50,
                      ),
                    ).cornerRadiusWithClipRRect(5),
                    title:
                        text("PayPal", textColor: appColorWhite, isBold: true),
                    subtitle: InkWell(
                        onTap: () {
                          _launchURL(
                              "https://www.paypal.com/uk/webapps/mpp/paypal-popup");
                        },
                        child: text("what is PayPal?",
                            textColor: appColorRed, fontSize: 14.0)),
                    leading: Radio<SingingCharacter>(
                      overlayColor: MaterialStateProperty.all(appColorRed),
                      activeColor: appColorRed,
                      fillColor: MaterialStateProperty.all(appColorRed),
                      // focusColor: appColorRed,
                      value: SingingCharacter.paypal,
                      groupValue: _chosenValue,
                      onChanged: (SingingCharacter? value) {
                        setState(() {
                          _chosenValue = value;
                          print("_chosenValue " + _chosenValue.toString());
                        });
                      },
                    ),
                  ),
                  10.height,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _launchURL(String _url) async => await canLaunch(_url)
      ? await launch(_url)
      : throw 'Could not launch $_url';

  List<LineItems> cartItemsToLineItems(List<WooCartItems>? items) {
    List<LineItems> lineItems = [];
    for (int i = 0; i < items!.length; i++) {
      print("id = " + items.elementAt(i).id.toString());
      lineItems.add(LineItems(
          variationId: 0,
          productId: (items.elementAt(i).id.toString()),
          quantity: (items.elementAt(i).quantity.toString())));
    }
    return lineItems;
  }


}

enum SingingCharacter { cash, paypal }

class ProductsInOrder extends StatelessWidget {
  List<WooCartItems>? items = [];

  ProductsInOrder(this.items);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Container(
      // height: 250,
      margin: EdgeInsets.only(bottom: 8, left: 8, right: 8, top: 5),

      child: StaggeredGridView.countBuilder(
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        shrinkWrap: true,
        itemCount: items!.length,
        itemBuilder: (BuildContext context, int index) =>
            productItem(items![index], context),
        staggeredTileBuilder: (int index) => new StaggeredTile.fit(2),
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
      ),
    );
  }

  Widget productItem(WooCartItems item, BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        color: grey /*backgroundColor*/,
        elevation: 5,
        child: InkWell(
          highlightColor: grey.withOpacity(0.2),
          overlayColor:
              MaterialStateProperty.all(Colors.grey /*.withOpacity(0.1)*/),
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                10.height,
                text(item.name,
                    maxLine: 2,
                    textColor: appColorWhite,
                    fontFamily: fontMedium,
                    fontSize: textSizeLargeMedium),
                SizedBox(height: spacing_standard),
                Image.network(item.images![0].src!,
                        width: width * 0.3,
                        height: width * 0.3,
                        fit: BoxFit.cover)
                    .cornerRadiusWithClipRRect(5),
                SizedBox(height: spacing_standard),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    text(
                      "Price:",
                      isBold: true,
                      textColor: appColorWhite,
                      fontFamily: fontMedium,
                      fontSize: textSizeLargeMedium,
                    ),
                    text(
                      item.prices!.price.toString().toCurrencyFormat(),
                      textColor: appColorWhite,
                      fontFamily: fontMedium,
                      fontSize: textSizeLargeMedium,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    text(
                      "Quantity:",
                      isBold: true,
                      textColor: appColorWhite,
                      fontFamily: fontMedium,
                      fontSize: textSizeLargeMedium,
                    ),
                    text(
                      item.quantity.toString(),
                      textColor: appColorWhite,
                      fontFamily: fontMedium,
                      fontSize: textSizeLargeMedium,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    text(
                      "Total price:",
                      isBold: true,
                      textColor: appColorWhite,
                      fontFamily: fontMedium,
                      fontSize: textSizeLargeMedium,
                    ),
                    text(
                      (int.parse(item.quantity.toString()) *
                              int.parse(item.prices!.price.toString()))
                          .toString()
                          .toCurrencyFormat(),
                      textColor: appColorWhite,
                      fontFamily: fontMedium,
                      fontSize: textSizeLargeMedium,
                    ),
                  ],
                ),
                10.height,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
