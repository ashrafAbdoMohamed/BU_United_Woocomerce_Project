
import 'package:bu_united_flutter_app/models/product_category.dart';
import 'package:bu_united_flutter_app/screens/ViewAllProductsInCategoryScreen.dart';
import 'package:bu_united_flutter_app/utils/AppColors.dart';
import 'package:bu_united_flutter_app/utils/AppWidget.dart';
import 'package:bu_united_flutter_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class CategoryItem extends StatefulWidget {
  late ProductCategory? category;
  late int pos;

  CategoryItem(ProductCategory? category, int pos) {
    this.category = category;
    this.pos = pos;
  }

  @override
  _CategoryItemState createState() => _CategoryItemState();
}

class _CategoryItemState extends State<CategoryItem> {
  late List<Color> cList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.pos++;
  }


  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.only(left: 8.0 , right: 8.0 , bottom: 8.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: BorderSide(
            color: appColorRed.withOpacity(0.5),
            width: 1.0,
          ),
        ),
        color: appColorRed.withOpacity(0.9),
        elevation: 5,
        shadowColor: appColorGrey.withOpacity(0.8),
        child: InkWell(
          onTap: () {
            goToPage(context, ViewAllProductScreen(category: widget.category,));
          },
          highlightColor: appColorRed.withOpacity(0.2),
          overlayColor:
          MaterialStateProperty.all(appColorRed),
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /*Container(
                  *//*decoration:
                  boxDecoration(bgColor: backgroundColor, radius: 12),*//*
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Image.asset(
                      getTheRightImage(widget.division!),
                      color: iconColor ?? null,
                      height: MediaQuery.of(context).size.width * 0.12,
                      width: MediaQuery.of(context).size.width * 0.12,
                      // color: Colors.amber,
                    ),
                  ),
                ),*/
                FittedBox(
                  child: Container(
                      //margin: EdgeInsets.only(bottom: 16),
                      child: Center(
                          child: FittedBox(
                            child: text(widget.category!.name , textColor: appColorWhite , fontSize: 22.0 ),
                          ))),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}