import 'package:bu_united_flutter_app/controllers/auth_controller.dart';
import 'package:bu_united_flutter_app/controllers/cart_controller.dart';
import 'package:bu_united_flutter_app/models/product_category.dart';
import 'package:bu_united_flutter_app/screens/ProductDetailsScreen.dart';
import 'package:bu_united_flutter_app/utils/AppColors.dart';
import 'package:bu_united_flutter_app/utils/AppConstant.dart';
import 'package:bu_united_flutter_app/utils/AppWidget.dart';
import 'package:bu_united_flutter_app/utils/account.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'package:nb_utils/nb_utils.dart';



// ignore: must_be_immutable
class ViewAllProductScreen extends StatefulWidget {
  static String tag = '/ViewAllProductScreen';

  // List<Product>? prodcuts;
  ProductCategory? category;
  var title;

  ViewAllProductScreen({this.category,/* this.title*/});

  @override
  ViewAllProductScreenState createState() {
    return ViewAllProductScreenState();
  }
}

class ViewAllProductScreenState extends State<ViewAllProductScreen> {
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

  void onListClick(which) {
    setState(() {
      if (which == 1) {
        isListViewSelected = true;
      } else if (which == 2) {
        isListViewSelected = false;
      }
    });
  }

  final cartController = Get.put(CartController());
  final authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;

    final listView = Container(
      child: (widget.category==null || widget.category!.products!.isEmpty ) ? Center(child: text("No product in this category"),) :ListView.builder(
        itemCount: widget.category!.products!.length,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) =>
                  ProductDetailsScreen(product: widget.category!.products![index])));
            },
            child: Container(
              decoration: boxDecoration(

              ),
              padding: EdgeInsets.all(10.0),
              child: IntrinsicHeight(
                child: Container(
                  color: appColorWhite.withOpacity(0.1),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      ProductImage(imgSrc: widget.category!.products![index].images![0].src! ,
                        productID: widget.category!.products![index].id ,),
                      10.width,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            text(widget.category!.products![index].name,
                                textColor: appColorWhite),
                            SizedBox(height: 4),
                            Row(
                              children: <Widget>[
                                priceText(widget.category!.products![index].onSale!
                                    ? widget.category!.products![index].salePrice.toString()
                                    .toCurrencyFormat()
                                    : widget.category!.products![index].price.toString()
                                    .toCurrencyFormat()),
                                SizedBox(
                                  width: spacing_control,
                                ),
                                oldPriceText(widget.category!.products![index].regularPrice.toString()
                                    .toCurrencyFormat()!),

                              ],
                            ),
                            SizedBox(
                              height: spacing_standard,
                            ),
                            customRichText(
                                text1: "Sold By:",
                                text2: "BU_UNITED",
                                size1: 16,
                                size2: 18,
                                color1: appShadowColor,
                                color2: appColorRed),
                            Expanded(
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    appButton(label: "Add to cart", onTap: (){
                                      cartController
                                          .addToMyCart(account.customerToken, widget.category!.products![index].id.toString(), "1")
                                          .then((value) {
                                        if (value == true) {
                                          snackBar(context, title: "cart updated");
                                          cartController.getMyCart(account.customerToken);
                                        }
                                      });
                                    }, btnWidth: width*0.29  ),
                                    10.width,
                                    CircleAvatar(
                                      backgroundColor: appShadowColor.withOpacity(0.2),
                                      child: Icon(
                                        Icons.favorite_border,
                                        color: appColorRed,
                                        size: 20,
                                      ),
                                    ),
                                    10.width,
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 4),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );


    return Scaffold(
      appBar: AppBar(
        backgroundColor: appColorRed,
        title: text(widget.category!.name, textColor: appColorWhite,
            fontSize: textSizeNormal,
            fontFamily: fontMedium),
        iconTheme: IconThemeData(color: appColorWhite),
        actionsIconTheme: IconThemeData(color: appColorWhite),
        /*actions: <Widget>[
          IconButton(icon: Icon(Icons.filter_list), color: appColorWhite,
              onPressed: () { *//*showMyBottomSheet(context)*//* }),
        ],*/
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: appColorBlack,
        child: SingleChildScrollView(
          controller: scrollController,
          child: listView,
        ),
      ),
    );
  }

}


