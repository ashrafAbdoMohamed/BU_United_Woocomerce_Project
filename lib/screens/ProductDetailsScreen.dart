import 'dart:convert';

import 'package:bu_united_flutter_app/controllers/auth_controller.dart';
import 'package:bu_united_flutter_app/controllers/cart_controller.dart';
import 'package:bu_united_flutter_app/controllers/products_controller.dart';
import 'package:bu_united_flutter_app/models/Product.dart';
import 'package:bu_united_flutter_app/models/Review.dart';
import 'package:bu_united_flutter_app/utils/AppColors.dart';
import 'package:bu_united_flutter_app/utils/AppConstant.dart';
import 'package:bu_united_flutter_app/utils/AppWidget.dart';
import 'package:bu_united_flutter_app/utils/account.dart';
import 'package:bu_united_flutter_app/utils/dataGenerator.dart';
import 'package:bu_united_flutter_app/utils/linear_percent_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

// ignore: must_be_immutable
class ProductDetailsScreen extends StatefulWidget {
  static String tag = '/ShProductDetail';
  Product? product;

  ProductDetailsScreen({this.product});

  @override
  ProductDetailsScreenState createState() => ProductDetailsScreenState();
}

class ProductDetailsScreenState extends State<ProductDetailsScreen> {
  var position = 0;

  bool autoValidate = false;
  TextEditingController controller = TextEditingController();
  PageController pageController = PageController();

  final productsController = Get.put(ProductsController());
  final cartController = Get.put(CartController());
  final authController = Get.put(AuthController());

  @override
  void initState() {
    super.initState();

    cartController.getMyCart(account.customerToken);

  }

  void getAllProducts() async {
    print("1");
    if (productsController.allProductsList.isEmpty) {
      print("2");
      productsController.getAllProducts().then(
          (value) => productsController.getAllRelatedProducts(widget.product!));
      print("3");
    } else {
      print("4");
      productsController.getAllRelatedProducts(widget.product!);
    }
    print("end 5");
  }

  // List<Product> relatedProducts = [];

  @override
  Widget build(BuildContext context) {
    getAllProducts();

    var width = MediaQuery.of(context).size.width;

    //TODO: Images Slide
    var sliderImages = Container(
      height: 380,
      child: Stack(
        children: [
          PageView.builder(
            controller: pageController,
            itemCount: widget.product!.images!.length,
            itemBuilder: (context, index) {
              return Hero(
                tag: widget.product!.id,
                child: Image.network(widget.product!.images![index].src!,
                    width: width, height: width * 1.05, fit: BoxFit.cover),
              );
            },
            onPageChanged: (index) {
              position = index;
              setState(() {});
            },
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {

                      if(position != 0){
                        setState(() {
                          position--;
                          pageController.animateToPage(position, duration: Duration(milliseconds: 500), curve: Curves.easeIn);
                        });
                      }
                    },
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor: appColorWhite.withOpacity(0.5),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: Align(
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      if (position != widget.product!.images!.length - 1) {
                        setState(() {
                          position++;
                          pageController.animateToPage(position, duration: Duration(milliseconds: 500), curve: Curves.easeIn);

                        });
                      }
                    },
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor: appColorWhite.withOpacity(0.5),
                      child: Align(
                        alignment: Alignment.center,
                        child: Icon(

                          Icons.arrow_forward_ios,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );

    //first section after the image pager
    //TODO: Name, prices , sold_by
    var productInfo = Container(
      color: appColorBlack,
      padding: EdgeInsets.all(14),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              text(widget.product!.name,
                  textColor: appColorWhite,
                  fontFamily: fontMedium,
                  fontSize: textSizeLarge),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5),
                color: Colors.red.withOpacity(0.4),
                // decoration: BoxDe,
                child: text(
                  widget.product!.onSale!
                      ? widget.product!.salePrice.toString().toCurrencyFormat()
                      : widget.product!.price.toString().toCurrencyFormat(),
                  textColor: appColorRed,
                  fontSize: textSizeLarge,
                  fontFamily: fontBold,
                ),
              ).cornerRadiusWithClipRRect(10)
            ],
          ),
          SizedBox(height: spacing_standard),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    customRichText(
                        text1: "Sold By: ",
                        text2: "BU_UNITED",
                        size1: 16,
                        size2: 20,
                        color1: appShadowColor,
                        color2: appColorRed),
                  ],
                ),
              ),
              Text(
                widget.product!.regularPrice.toString().toCurrencyFormat()!,
                style: TextStyle(
                    color: appColorGrey,
                    fontFamily: fontRegular,
                    fontSize: textSizeLargeMedium,
                    decoration: TextDecoration.lineThrough),
              )
            ],
          )
        ],
      ),
    );

    var descriptionTab = SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8),
        child: Container(
          width: width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              text("Description: ", fontSize: 20.0, textColor: appColorAccent),
              text(
                  widget.product!.description == ""
                      ? "-"
                      : widget.product!.description,
                  fontSize: 20.0,
                  textColor: appColorWhite),
            ],
          ),
        ),
      ),
    );

    Widget dimensionRow(String label, String value) {
      return Row(
        children: <Widget>[
          Expanded(
            child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(
                    top: spacing_control, bottom: spacing_control),
                color: appColorGrey.withOpacity(0.1),
                child: text(label,
                    textColor: appColorRed,
                    fontFamily: fontMedium,
                    fontSize: textSizeLargeMedium)),
          ),
          10.width,
          Expanded(
            child: Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(
                    top: spacing_control,
                    bottom: spacing_control,
                    left: spacing_large),
                color: appColorGrey.withOpacity(0.1),
                child: text(value,
                    textColor: appColorWhite,
                    fontFamily: fontMedium,
                    fontSize: textSizeLargeMedium)),
          )
        ],
      );
    }

    var dimensionsTab = SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8),
        child: Container(
          width: width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              text("More Info: ", fontSize: 20.0, textColor: appColorAccent),
              5.height,
              dimensionRow(
                  "Length:", widget.product!.dimensions!.length! + " cm"),
              3.height,
              dimensionRow(
                  "Height:", widget.product!.dimensions!.height! + " cm"),
              3.height,
              dimensionRow(
                  "Width:", widget.product!.dimensions!.width! + " cm"),
            ],
          ),
        ),
      ),
    );


    Widget relatedProductsTab() {
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8),
          child: Container(
            width: width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                text("Related Products: ",
                    fontSize: 20.0, textColor: appColorAccent),
                5.height,
                ProductHorizontalList(productsController.relatedProducts),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: appBar(context, widget.product!.name),
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: appColorBlack,
        child: Stack(
          children: [
            Positioned(
                bottom: 20,
                left: 10,
                right: 10,
                child: Obx(
                    () =>
                    (cartController.isLoading.value) ? Center(child: CircularProgressIndicator()):
                        appSmallButton(
                      label: "Add To Cart", onTap: () {
                        String oldQuantity = "0";
                        if(cartController.myCart.value.items != null){
                        if(cartController.myCart.value.items!.isNotEmpty){
                          cartController.myCart.value.items!.map((e) {
                            if(e.id.toString() == widget.product!.id.toString()){
                              oldQuantity = e.quantity;
                            }
                          });
                        }
                        }
                        print("TOTO" + account.customerToken);
                    cartController.addToMyCart(account.customerToken,
                        widget.product!.id.toString(), (int.parse(oldQuantity)+1).toString()).then((value) {
                      if(value == true){
                        snackBar(context , title: "item added to cart!");
                        cartController.getMyCart(account.customerToken);
                      }
                    });
                  }, btnWidth: width - 20),
                )),
            Container(
              height: MediaQuery.of(context).size.height,
              margin: EdgeInsets.only(bottom: 70),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    sliderImages,
                    productInfo,
                    10.height,
                    descriptionTab,
                    10.height,
                    dimensionsTab,
                    10.height,
                    relatedProductsTab(),

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
