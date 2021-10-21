import 'package:bu_united_flutter_app/controllers/auth_controller.dart';
import 'package:bu_united_flutter_app/controllers/products_controller.dart';
import 'package:bu_united_flutter_app/models/product_category.dart';
import 'package:bu_united_flutter_app/screens/HomeDashboard.dart';
import 'package:bu_united_flutter_app/screens/widgets/category_item.dart';
import 'package:bu_united_flutter_app/utils/AppColors.dart';
import 'package:bu_united_flutter_app/utils/AppConstant.dart';
import 'package:bu_united_flutter_app/utils/AppWidget.dart';
import 'package:bu_united_flutter_app/utils/account.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'ViewAllProductsInCategoryScreen.dart';

class HomeScreen extends StatefulWidget {
  static String tag = '/ShHomeFragment';

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final productsController = Get.put(ProductsController());
  var loading = true.obs;

  @override
  void initState() {
    super.initState();
  }

  final auth = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    getAccessToken();
    print("new = " +
        "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvYnUtdW5pdGVkLWludGVybmV0LmNvbSIsImlhdCI6MTYzMTk0MTQzMSwibmJmIjoxNjMxOTQxNDMxLCJleHAiOjE2MzI1NDYyMzEsImRhdGEiOnsidXNlciI6eyJpZCI6OSwiZGV2aWNlIjoiIiwicGFzcyI6ImJiZTVjOTU0MWQxOTVlOGFlZGZhOGQ2ZTU0NmZlZmQyIn19fQ.n1mFKWU7YQYmSYoFNP0hG794llOSLebvHfBfcykca2w"
            .length
            .toString());
    return Obx(
      () => Container(
        height: height,
        color: appColorBlack,
        // padding: EdgeInsets.only(bottom: 30),
        child: (productsController.isLoading.value == true)
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                physics: ScrollPhysics(),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 14.0),
                      child: Container(
                          width: width,
                          child: text("Categories",
                              // isBold: true,
                              textColor: appColorWhite,
                              isCentered: false,
                              fontSize: 22.0)),
                    ),
                    //TODO: Divisions Sections
                    Container(
                      height: 70,
                      // color: Colors.green,
                      child:
                          Obx(
                        () => (productsController.isLoading.value)
                            ? Center(child: CircularProgressIndicator())
                            : ListView.builder(
                                // physics: NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemCount:
                                    // productsController.allCategoriesList.length,
                                fakeCategoriesList.length,
                                shrinkWrap: true,
                                padding: EdgeInsets.only(right: 16),
                                itemBuilder: (context, index) {
                                  return Container(
                                    width: 150,
                                    child: CategoryItem(
                                        // productsController.allCategoriesList[index],
                                        fakeCategoriesList[index],
                                        index),
                                  );
                                },
                              ),
                      ),
                    ),
                    Column(
                      children: productsController.allCategoriesList
                          .map((item) => CategoryProductsItem(item!))
                          .toList(),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  Future<String>? getAccessToken() {
    final auth = Get.put(AuthController());
    auth
        .customerLogin(
            emailOrUserName: auth.loggedInCustomer.value.email,
            password: account.pass,
            onFailed: (msg) {
              print("msg = " + msg.toString());
            })
        .then((customer) {
      account.customerId = customer!.id.toString();
      account.customerToken = customer.token.toString();
      print(account.customerToken + " ACCESS TOKEN");
      return account.customerToken;
    });
  }

  Widget CategoryProductsItem(ProductCategory productCategory) {
    //todo horizontal products + (its title .. view all)
    return (productCategory.products!.isEmpty)
        ? SizedBox()
        : Column(
            children: [
              productsHorizontalHeading(productCategory.name, callback: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ViewAllProductScreen(category: productCategory)));
              }),
              ProductHorizontalList(productCategory.products!),
              SizedBox(height: spacing_standard_new),
            ],
          );
  }
}

class DrawerItem extends StatelessWidget {
  String title;
  IconData icon;
  Function? onTap;

  DrawerItem(this.title, this.icon, {this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: appColorWhite.withOpacity(0.3),
          borderRadius: BorderRadius.circular(6),
        ),
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
          Row(
            children: [
              Icon(
                icon,
                size: 24,
                color: Colors.black54,
              ),
              5.width,
              Text(
                title.toUpperCase(),
                style: Theme.of(context)
                    .textTheme
                    .subtitle2!
                    .copyWith(fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const Spacer(),
          Icon(
            Icons.keyboard_arrow_right,
            color: appColorBlack,
            size: 20,
          ),
        ])).onTap(() {
      onTap!();
    });
  }
}
