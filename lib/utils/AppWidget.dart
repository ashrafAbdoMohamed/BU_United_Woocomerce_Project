import 'package:bu_united_flutter_app/models/Product.dart';
import 'package:bu_united_flutter_app/screens/ProductDetailsScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'AppColors.dart';
import 'AppConstant.dart';
import 'package:bu_united_flutter_app/utils/AppColors.dart';

import 'AppImages.dart';

class ProductHorizontalList extends StatelessWidget {
  List<Product> products = [];
  ProductHorizontalList(this.products );

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery
        .of(context)
        .size
        .width;
    if (products.length > 0) print("IIIIII " + products[0].images![0].src!);
    return Container(
      height: 250,
      margin: EdgeInsets.only(top: spacing_standard_new),
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: products.length,
          shrinkWrap: true,
          padding: EdgeInsets.only(right: spacing_standard_new),
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.only(left: spacing_standard_new),
              width: width * 0.4,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ProductDetailsScreen(product: products[index])));
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Hero(
                      tag: products[index].id,
                      child: Image.network(products[index].images![0].src!,
                          width: width * 0.4,
                          height: width * 0.4,
                          fit: BoxFit.cover)
                          .cornerRadiusWithClipRRect(5),
                    ),
                    SizedBox(height: spacing_standard),
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                              child: text(products[index].name,
                                  maxLine: 2,
                                  textColor: appColorWhite,
                                  fontFamily: fontMedium,
                                  fontSize: textSizeMedium)),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                products[index]
                                    .regularPrice
                                    .toString()
                                    .toCurrencyFormat()!,
                                style: TextStyle(
                                    color: appColorRed,
                                    fontFamily: fontRegular,
                                    fontSize: textSizeMedium,
                                    decoration: TextDecoration.lineThrough),
                              ),
                              SizedBox(width: spacing_control_half),
                              text(
                                products[index].onSale!
                                    ? products[index]
                                    .salePrice
                                    .toString()
                                    .toCurrencyFormat()
                                    : products[index]
                                    .price
                                    .toString()
                                    .toCurrencyFormat(),
                                isBold: true,
                                textColor: appColorWhite,
                                fontFamily: fontMedium,
                                fontSize: textSizeLargeMedium,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}






extension StringExtension on String? {
  String? toCurrencyFormat({var format = '\$'}) {
    return format + this;
  }

/* String formatDateTime() {
    if (this == null || this!.isEmpty || this == "null") {
      return "NA";
    } else {
      return DateFormat("HH:mm dd MMM yyyy", "en_US").format(DateFormat("yyyy-MM-dd HH:mm:ss.0", "en_US").parse(this!));
    }
  }

  String formatDate() {
    if (this == null || this!.isEmpty || this == "null") {
      return "NA";
    } else {
      return DateFormat("dd MMM yyyy", "en_US").format(DateFormat("yyyy-MM-dd", "en_US").parse(this!));
    }
  }*/
}

Widget productsHorizontalHeading(var title, {bool showViewAll = true, var callback}) {
  return Padding(
    padding: const EdgeInsets.only(
      left: spacing_standard_new,
      right: spacing_standard_new,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        text(title,
            fontSize: 18.0,
            textColor: appColorWhite,
            fontFamily: fontMedium),
        showViewAll
            ? GestureDetector(
          onTap: callback,
          child: Container(
            padding: EdgeInsets.only(
                left: spacing_standard_new,
                top: spacing_control,
                bottom: spacing_control),
            child: text("View all", fontSize: 16.0, isBold: true,
                textColor: appColorWhite, fontFamily: fontMedium),
          ),
        )
            : Container()
      ],
    ),
  );
}

// ignore: must_be_immutable
Widget checkoutButton(
    {required String label,
      required Function onTap,
      required double btnWidth}) {
  return Container(
    width: btnWidth,
    alignment: Alignment.center,
    padding: EdgeInsets.fromLTRB(20, 12, 20, 12),
    decoration: BoxDecoration(
        color: appColorRed,
        borderRadius: BorderRadius.circular(8),
        boxShadow: defaultBoxShadow()),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(label, style: boldTextStyle(color: white, size: 20)),
        10.width,
        Icon(Icons.shopping_cart_outlined , color: Colors.white,),
      ],
    ),
  ).onTap(() {
    onTap();
  });
}
Widget checkoutTotal(
    {required String label,
      required double width}) {
  return Container(
    width: width,
    alignment: Alignment.center,
    padding: EdgeInsets.fromLTRB(20, 12, 20, 12),
    //color: appColorRed.withOpacity(0.3),
    decoration: BoxDecoration(
        color: appColorRed.withOpacity(0.3),
        borderRadius: BorderRadius.circular(8),
        /*boxShadow: defaultBoxShadow()*/),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(label, style: TextStyle(color: appColorRed , fontSize: 20),),
      ],
    ),
  );
}
Widget appSmallButton(
    {required String label,
      required Function onTap,
      required double btnWidth , AlignmentGeometry? alignmentGeometry}) {
  return Container(
    width: btnWidth,
    alignment: alignmentGeometry ?? Alignment.center,
    padding: EdgeInsets.fromLTRB(20, 12, 20, 12),
    decoration: BoxDecoration(
        color: appColorRed,
        borderRadius: BorderRadius.circular(8),
        boxShadow: defaultBoxShadow()),
    child: Text(label, style: boldTextStyle(color: white, size: 18)),
  ).onTap(() {
    onTap();
  });
}
Widget appButton(
    {required String label,
      required Function onTap,
      required double btnWidth,
      Color? backgroundColor}) {
  return Container(
    width: btnWidth,
    child: ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all( backgroundColor ?? appColorRed),
        enableFeedback: true,
      ),
      onPressed: (){
        onTap();
      },
      child: FittedBox(child: Text(label, style: TextStyle(color: white, fontSize: 18))),
    ),
  );
}
/*Widget appSmallButton(
    {required String label,
      required Function onTap,
      required double btnWidth}) {
  return Container(
    width: btnWidth,
    alignment: Alignment.center,
    padding: EdgeInsets.fromLTRB(20, 12, 20, 12),
    decoration: BoxDecoration(
        color: appColorRed,
        borderRadius: BorderRadius.circular(8),
        boxShadow: defaultBoxShadow()),
    child: Text(label, style: boldTextStyle(color: white, size: 18)),
  ).onTap(() {
    onTap();
  });
}*/
Widget requiredTextFieldRichText(String text) {
  return Container(
    alignment: Alignment.centerLeft,
    child: Padding(
      padding: const EdgeInsets.only(left: 4.0),
      child: RichText(
          text: TextSpan(
              style: TextStyle(
                fontSize: 16,
              ),
              children: [
                TextSpan(text: text, style: TextStyle(color: Colors.white)),
                TextSpan(text: " *", style: TextStyle(color: appColorRed)),
              ])),
    ),
  );
}
Widget customRichText({required String text1 ,required String text2 ,required Color color1 ,required Color color2 ,required double size1 ,required double size2}) {
  return Padding(
    padding: const EdgeInsets.only(left: 4.0),
    child: RichText(
        text: TextSpan(
/*            style: TextStyle(
              fontSize: 14,
            ),*/
            children: [
              TextSpan(text: text1, style: TextStyle(color: color1 , fontSize: size1)),
              TextSpan(text: text2, style: TextStyle(color: color2 , fontSize: size2)),
            ])),
  );
}

Widget whiteEditText(String hintText,TextEditingController controller ,  {TextInputType? textInputType , FocusNode? focusNode}){
  return Padding(
    padding: const EdgeInsets.only(bottom: 8.0),
    child: TextFormField(
      controller: controller,
      style: primaryTextStyle(color: appColorBlack),
      decoration: InputDecoration(
        filled: true,
        hintText: hintText,
        fillColor: boxBackgroundColor,
        contentPadding: EdgeInsets.all(16),
        labelStyle: secondaryTextStyle(),
        border: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(color: appColorRed)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(color: appColorBlack)),
      ),
      keyboardType: textInputType ?? TextInputType.text,

      textInputAction: TextInputAction.next,
    ),
  );
}

Widget editTextWithTitle(String title , TextEditingController controller
    , {TextInputType? textInputType , FocusNode? nextFocusNode}) {
  return Padding(
    padding: const EdgeInsets.only(left: 4.0),
    child: Column(
      children: [
        text("" , textColor: appColorGrey , fontSize: 16.0),
        TextFormField(
          controller: controller,
          style: TextStyle(color: appColorWhite , fontWeight: FontWeight.bold , fontSize: 18),
          decoration: InputDecoration(
            filled: true,
            hintText: title,
            hintStyle: TextStyle(color: appShadowColor.withOpacity(0.3) , fontWeight: FontWeight.normal),
            fillColor: appColorWhite.withOpacity(0.3),
            contentPadding: EdgeInsets.all(16),
            labelStyle: secondaryTextStyle(),
            border: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(color: appColorRed)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(color: appColorBlack)),
          ),
          keyboardType: textInputType ?? TextInputType.text,
          /*onFieldSubmitted: (s) =>
              FocusScope.of(context).requestFocus(passFocus),
          textInputAction: TextInputAction.next,*/
        ),
      ],
    ),
  );
}

showLoaderDialog(BuildContext context){
    AlertDialog alert=AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(margin: EdgeInsets.only(left: 7),child:Text("Loading..." )),
        ],),
    );
    showDialog(barrierDismissible: false,
      context:context,
      builder:(BuildContext context){
        return alert;
      },
    );
}


Widget appBarTitleWidget(context, String title,
    {Color? color, Color? textColor}) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 60,
    color: color ?? appColorRed,
    child: Row(
      children: <Widget>[
        Text(
          title,
          style: boldTextStyle(color: textColor ?? textPrimaryColor, size: 20),
          maxLines: 1,
        ).expand(),
      ],
    ),
  );
}

AppBar appBar(BuildContext context, String title,
    {List<Widget>? actions,
      bool showBack = true,
      Color? color,
      Color? iconColor,
      Color? textColor}) {
  return AppBar(
    automaticallyImplyLeading: false,
    backgroundColor: color ?? appColorRed,
    leading: showBack
        ? IconButton(
      onPressed: () {
        finish(context);
      },
      icon: Icon(Icons.arrow_back, color: appColorWhite),
    )
        : null,
    title: appBarTitleWidget(context, title,
        textColor: appColorWhite, color: color),
    actions: actions,
  );
}

Widget text(
    String? text, {
      var fontSize = textSizeLargeMedium,
      Color? textColor,
      var fontFamily,
      var isCentered = false,
      var maxLine = 1,
      var latterSpacing = 0.5,
      bool textAllCaps = false,
      var isLongText = false,
      var isBold = false,
      bool lineThrough = false,
    }) {
  return Text(
    textAllCaps ? text!.toUpperCase() : text!,
    textAlign: isCentered ? TextAlign.center : TextAlign.start,
    maxLines: isLongText ? null : maxLine,
    overflow: TextOverflow.ellipsis,
    style: TextStyle(
      fontFamily: fontFamily ?? null,
      fontSize: fontSize,
      fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
      color: textColor ?? appTextColorSecondary,
      height: 1.5,
      letterSpacing: latterSpacing,
      decoration:
      lineThrough ? TextDecoration.lineThrough : TextDecoration.none,
    ),
  );
}

BoxDecoration boxDecoration(
    {double radius = 2,
      Color color = Colors.transparent,
      Color? bgColor,
      var showShadow = false}) {
  return BoxDecoration(
    color: bgColor,
    boxShadow: showShadow
        ? defaultBoxShadow(shadowColor: shadowColorGlobal)
        : [BoxShadow(color: Colors.transparent)],
    border: Border.all(color: color),
    borderRadius: BorderRadius.all(Radius.circular(radius)),
  );
}

/*Widget commonCacheImageWidget(String? url, double height,
    {double? width, BoxFit? fit}) {
  if (url.validate().startsWith('http')) {
    if (isMobile) {
      return CachedNetworkImage(
        placeholder:
            placeholderWidgetFn() as Widget Function(BuildContext, String)?,
        imageUrl: '$url',
        height: height,
        width: width,
        fit: fit,
        errorWidget: (_, __, ___) {
          return SizedBox(height: height, width: width);
        },
      );
    } else {
      return Image.network(url!, height: height, width: width, fit: fit);
    }
  } else {
    return Image.asset(url!, height: height, width: width, fit: fit);
  }
}*/

Widget? Function(BuildContext, String) placeholderWidgetFn() =>
        (_, s) => placeholderWidget();

Widget placeholderWidget() =>
    Image.asset('images/LikeButton/image/grey.jpg', fit: BoxFit.cover);

class ProductImage extends StatelessWidget {

  String imgSrc;
  var productID;
  ProductImage({required this.imgSrc , this.productID});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery
        .of(context)
        .size
        .width;
    return Container(
      padding: EdgeInsets.all(1),
      //decoration: BoxDecoration(border: Border.all(color: sh_view_color, width: 1)),
      child: Hero(
        tag: productID ?? "",
        child: Image.network( imgSrc
            , fit: BoxFit
                .fill, height: width * 0.35, width: width * 0.35).cornerRadiusWithClipRRect(5),
      )
      /*.cornerRadiusWithClipRRect(10)*/,
    );
  }
}

Widget priceText(String? price){
  return text(price,
        textColor: appColorRed,
        fontFamily: fontMedium,
        fontSize: 22.0);
}
Widget oldPriceText(String? price){
  return Text(price!,
      style: TextStyle(color: appColorGrey,
          fontFamily: fontRegular,
          fontSize: textSizeSmall,
          decoration: TextDecoration.lineThrough));
}

