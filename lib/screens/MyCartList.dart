import 'package:bu_united_flutter_app/controllers/auth_controller.dart';
import 'package:bu_united_flutter_app/controllers/cart_controller.dart';
import 'package:bu_united_flutter_app/controllers/customer_controller.dart';
import 'package:bu_united_flutter_app/controllers/products_controller.dart';
import 'package:bu_united_flutter_app/models/product_category.dart';
import 'package:bu_united_flutter_app/screens/OrderScreen.dart';
import 'package:bu_united_flutter_app/utils/AppColors.dart';
import 'package:bu_united_flutter_app/utils/AppWidget.dart';
import 'package:bu_united_flutter_app/utils/account.dart';
import 'package:bu_united_flutter_app/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:nb_utils/nb_utils.dart';

import 'ProductDetailsScreen.dart';

// ignore: must_be_immutable
class MyCartList extends StatefulWidget {
  static String tag = '/ViewAllProductScreen';

  // List<Product>? prodcuts;
  ProductCategory? category;
  var title;

  MyCartList({
    this.category,
    /* this.title*/
  });

  @override
  MyCartListState createState() {
    return MyCartListState();
  }
}

class MyCartListState extends State<MyCartList> {
  var sortType = -1;

  // List<Product> widget.prodcuts! = [];

  var isListViewSelected = false;
  var errorMsg = '';
  var scrollController = new ScrollController();
  bool isLoading = false;
  bool isLoadingMoreData = false;
  int page = 1;
  bool isLastPage = false;
  var primaryColor;

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  final cartController = Get.put(CartController());
  final productsController = Get.put(ProductsController());
  final authController = Get.put(AuthController());
  final customerController = Get.put(CustomerController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    var formatter = NumberFormat('#,###.##');

    return ProgressHUD(
      child: Obx(
        () => (cartController.isLoading.value)
            ? Center(child: text("Getting data.."))
            : (!cartController.isLoading.value &&
            ( cartController.myCart.value.items == null || cartController.myCart.value.items!.isEmpty ))
            ? Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  text("No Items In Your cart..", fontSize: 20.0),
                  /*20.height,
                  appSmallButton(
                      label: "Return to shop",
                      onTap: () {
                        finish(context);
                      },
                      btnWidth: width / 2),*/
                ],
              ),
            ))
            :
        Container(
            height: MediaQuery.of(context).size.height,
            color: appColorBlack,
            child: Stack(
              children: [
                Positioned(
                  bottom: 20,
                  left: 10,
                  right: 10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Obx(
                        ()=> (authController.isLoading.value)
                            ? Container(width: width * 0.4,child: Center(child: CircularProgressIndicator()))
                            : checkoutButton(
                          btnWidth: width * 0.4,
                          label: "Checkout",
                          onTap: () {
                            //get Customer data;
                            authController.getCustomerByID(account.customerId).then((customer) {
                              if(customer != null){
                                goToPage(context, OrderScreen());
                              }
                            });

                          },
                        ),
                      ),
                      checkoutTotal(
                        width: width * 0.4,
                        label: (cartController.myCart.value.totals == null) ? "Total: " :
                        "Total: " + cartController.myCart.value.totals!.totalPrice +
                            cartController.myCart.value.totals!.currencyPrefix,
                      ),

                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 75),
                  height: MediaQuery.of(context).size.height,
                  color: appColorBlack,
                  child: ListView.builder(
                                itemCount: cartController.myCart.value.items!.length,
                                //physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      print("GO");
                                      if (productsController.allProductsList.isNotEmpty) {
                                        print("Not Empty");
                                        for (int i = 0; i < productsController.allProductsList.length; i++) {
                                          if (productsController.allProductsList.elementAt(i)!.id.toString() ==
                                              cartController.myCart.value.items!.elementAt(index).id.toString()) {
                                            goToPage(context, ProductDetailsScreen(
                                                product: productsController.allProductsList .elementAt(i)));
                                          }
                                        }
                                      } else {
                                        print("EMPTY!");
                                      }
                                    },
                                    child: Container(
                                      color: appColorWhite.withOpacity(0.1),
                                      margin: EdgeInsets.all(10.0),
                                      child: IntrinsicHeight(
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: <Widget>[
                                            ProductImage(
                                                imgSrc: cartController.myCart.value.items!
                                                    .elementAt(index).images![0].src ??
                                                    "",
                                                productID: cartController.myCart.value.items!
                                                    .elementAt(index).id),
                                            SizedBox(width: 10),
                                            Expanded(
                                              child: Container(
                                                padding: EdgeInsets.all(10.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        text(
                                                            cartController
                                                                .myCart.value.items!
                                                                .elementAt(index)
                                                                .name,
                                                            textColor: appColorWhite),
                                                        Obx(
                                                          () =>
                                                          (cartController.isDeleting.value) ?
                                                          Center(child: CircularProgressIndicator())
                                                              : CircleAvatar(
                                                            backgroundColor:
                                                                appShadowColor
                                                                    .withOpacity(0.2),
                                                            child: Icon(
                                                              Icons.delete_forever,
                                                              color: appColorWhite,
                                                              size: 20,
                                                            ),
                                                          ).onTap(() {
                                                            cartController
                                                                .deleteCartItem(
                                                                account.customerToken,
                                                                    cartController
                                                                        .myCart
                                                                        .value
                                                                        .items!
                                                                        .elementAt(
                                                                            index)
                                                                        .key
                                                                        .toString())
                                                                .then((value) {
                                                              if (value == true) {
                                                                cartController
                                                                    .getMyCart(account.customerToken)
                                                                    .then((value) {
                                                                  /*setState(() {
                                                                    cartController
                                                                        .myCart
                                                                        .value
                                                                        .items!
                                                                        .removeAt(
                                                                            index);
                                                                    snackBar(context,
                                                                        title:
                                                                            "item deleted");
                                                                  });*/
                                                                });
                                                                /*cartController.myCart.value.items!.removeWhere((element) => element.key == cartController.myCart.value.items!.elementAt(index).key);
                                                            cartController.update();
                                                            setState(() {
                                                            });*/
                                                              }
                                                            });
                                                          }),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 4),
                                                    customRichText(
                                                        text1: "Sold By:",
                                                        text2: "BU_UNITED",
                                                        size1: 16,
                                                        size2: 18,
                                                        color1: appShadowColor,
                                                        color2: appColorRed),
                                                    Expanded(
                                                      child: Container(
                                                        child: Align(
                                                          alignment:
                                                              Alignment.bottomCenter,
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: <Widget>[
                                                              Container(
                                                                child: Row(
                                                                  children: [
                                                                    Obx(
                                                                      ()=>
                                                                      (cartController.isDecreasing.value) ?
                                                                      Center(child: CircularProgressIndicator())
                                                                          : CircleAvatar(
                                                                        backgroundColor:
                                                                            appShadowColor
                                                                                .withOpacity(
                                                                                    0.2),
                                                                        child: Icon(
                                                                          Icons
                                                                              .minimize,
                                                                          color:
                                                                              appColorWhite,
                                                                          size: 20,
                                                                        ),
                                                                      ).onTap(() {
                                                                        subtractOneFromCart(
                                                                            cartController
                                                                                .myCart
                                                                                .value
                                                                                .items!
                                                                                .elementAt(
                                                                                    index)
                                                                                .id
                                                                                .toString());
                                                                      }),
                                                                    ),
                                                                    5.width,
                                                                    Container(
                                                                      width: 40,
                                                                      child: Text(
                                                                        cartController
                                                                            .myCart
                                                                            .value
                                                                            .items!
                                                                            .elementAt(
                                                                                index)
                                                                            .quantity
                                                                            .toString(),
                                                                        textAlign:
                                                                            TextAlign
                                                                                .center,
                                                                        style: TextStyle(
                                                                            color:
                                                                                appColorWhite,
                                                                            fontSize:
                                                                                18,
                                                                            fontWeight:
                                                                                FontWeight
                                                                                    .bold),
                                                                      ),
                                                                    ),
                                                                    5.width,
                                                                    Obx(
                                                                      ()=>
                                                                      (cartController.isIncreasing.value) ?
                                                                          Center(child: CircularProgressIndicator())
                                                                          : CircleAvatar(
                                                                        backgroundColor:
                                                                            appShadowColor
                                                                                .withOpacity(
                                                                                    0.2),
                                                                        child: Icon(
                                                                          Icons.add,
                                                                          color:
                                                                              appColorWhite,
                                                                          size: 20,
                                                                        ),
                                                                      ).onTap(() {
                                                                        addOneToCart(cartController
                                                                            .myCart
                                                                            .value
                                                                            .items!
                                                                            .elementAt(
                                                                                index)
                                                                            .id
                                                                            .toString());
                                                                      }),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              priceText(formatter.format(
                                                                      int.parse(cartController
                                                                          .myCart
                                                                          .value
                                                                          .items!
                                                                          .elementAt(
                                                                              index)
                                                                          .prices!
                                                                          .price
                                                                          .toString())) +
                                                                  cartController
                                                                      .myCart
                                                                      .value
                                                                      .items!
                                                                      .elementAt(
                                                                          index)
                                                                      .prices!
                                                                      .currencyPrefix
                                                                      .toString()),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(height: 4),
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                  ),
              ],
            ),
        ),
      ),
    );
  }

  void addOneToCart(String productId) {
    cartController
        .addToMyCart(account.customerToken, productId, "1")
        .then((value) {
      if (value == true) {
        snackBar(context, title: "cart updated");
        cartController.getMyCart(account.customerToken).then((value) {
          setState(() {});
        });
      }
    });
  }

  void subtractOneFromCart(String productId) {
    cartController
        .addToMyCart(account.customerToken, productId, "-1")
        .then((value) {
      if (value == true) {
        snackBar(context, title: "cart updated");
        cartController.getMyCart(account.customerToken).then((value) {
          setState(() {});
        });
      }
    });
  }

}
