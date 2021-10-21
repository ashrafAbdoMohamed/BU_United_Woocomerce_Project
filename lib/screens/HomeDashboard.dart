import 'package:bu_united_flutter_app/controllers/auth_controller.dart';
import 'package:bu_united_flutter_app/controllers/cart_controller.dart';
import 'package:bu_united_flutter_app/controllers/customer_controller.dart';
import 'package:bu_united_flutter_app/controllers/products_controller.dart';
import 'package:bu_united_flutter_app/models/customer.dart';
import 'package:bu_united_flutter_app/models/product_category.dart';
import 'package:bu_united_flutter_app/models/woo/cart.dart';
import 'package:bu_united_flutter_app/screens/HomeScreen.dart';
import 'package:bu_united_flutter_app/screens/MyCartList.dart';
import 'package:bu_united_flutter_app/screens/widgets/billing_address_widget.dart';
import 'package:bu_united_flutter_app/screens/widgets/shipping_address_widget.dart';
import 'package:bu_united_flutter_app/utils/AppColors.dart';
import 'package:bu_united_flutter_app/utils/AppImages.dart';
import 'package:bu_united_flutter_app/utils/AppWidget.dart';
import 'package:bu_united_flutter_app/utils/account.dart';
import 'package:bu_united_flutter_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import 'OrderDetailsScreen.dart';
import 'OrdersListScreen.dart';
import 'ProfileScreen.dart';
import 'DTSignInScreen.dart';
import 'ShippingScreen.dart';
import 'ViewAllProductsInCategoryScreen.dart';
import 'expanded.dart';

class HomeDashboard extends StatefulWidget {
  static String tag = '/LearnerDashboard';

  @override
  _HomeDashboardState createState() => _HomeDashboardState();
}

List<ProductCategory> fakeCategoriesList = [];

class _HomeDashboardState extends State<HomeDashboard> {
  var selectedIndex = 0;

  var pages;

  final customerController = Get.put(CustomerController());
  final cartController = Get.put(CartController());
  final authController = Get.put(AuthController());

  @override
  void initState() {
    String a =
        "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvd3d3LmJ1LXVuaXRlZC1pbnRlcm5ldC5jb20iLCJpYXQiOjE2MzA1MTIzMTMsIm5iZiI6MTYzMDUxMjMxMywiZXhwIjoxNjMxMTE3MTEzLCJkYXRhIjp7InVzZXIiOnsiaWQiOjM4LCJkZXZpY2UiOiIiLCJwYXNzIjoiOGQ2NmJmYWE5ZTQ2NTRmYWYxNDcwMWM2NzQ0ZTY5NDgifX19.ZVYm0kAB8jUfXkuEUKlxxSnaEuUmSgDQhHtGN57WOJA";
    print("a = " + a.length.toString());
    String b =
        "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvd3d3LmJ1LXVuaXRlZC1pbnRlcm5ldC5jb20iLCJpYXQiOjE2MzA4ODk2MjYsIm5iZiI6MTYzMDg4OTYyNiwiZXhwIjoxNjMxNDk0NDI2LCJkYXRhIjp7InVzZXIiOnsiaWQiOjUwLCJkZXZpY2UiOiIiLCJwYXNzIjpudWxsfX19.IAWEcrHs60QpcwPX9j9CQHr2uKauGw-GlWEUa_N9sX8";
    print("b = " + b.length.toString());
    super.initState();

    print("authController.loggedInCustomer.value.id = " +
        account.customerId.toString());

    /*//TODO:Customer
      authController
          .getCustomerByID(account.customerId.toString())
          .then((customer) {
        print("returned = " + customer!.avatarUrl.toString());
        // customerController.isLoading(false);
      });*/

    //TODO: Products
    productsController.getAllProductsCategories().then((v) {
      //todo: Building the fake list
      for (int i = 0; i < productsController.allCategoriesList!.length; i++) {
        fakeCategoriesList.add(productsController.allCategoriesList[i]!);
      }
      for (int i = 0; i < productsController.allCategoriesList!.length; i++) {
        fakeCategoriesList.add(productsController.allCategoriesList[i]!);
      }
      productsController.getAllProducts().then((value) {
        productsController.putAllProductsInCategories();
        print("FULL");
        print("IS? " + productsController.isLoading.value.toString());
        /* setState(() {

        });*/
        // productsController.isLoading(false);
      });
    });

    //TODO: Cart
    cartController.getMyCart(account.customerToken);

    selectedIndex = 0;
    pages = [
      HomeScreen(),
      MyCartList(),
      ProfileScreen(),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
      print(selectedIndex);
    });
  }

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  final productsController = Get.put(ProductsController());
  int currentIndex2 = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: appColorRed,
        title: text(
          (selectedIndex == 0)
              ? 'Home'
              : (selectedIndex == 1)
                  ? "My Cart"
                  : "Profile",
          textColor: appColorWhite,
          isBold: true,
          fontSize: 20.0,
        ),
        // automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            scaffoldKey.currentState!.openDrawer();
          },
        ),
      ),
      drawer: ClipPath(
        clipper: OvalRightBorderClipper(),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Drawer(
          child: Container(
            padding: const EdgeInsets.only(left: 16.0, right: 40),
            decoration: BoxDecoration(
              color: appColorBlack,
            ),
            width: 300,
            child: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        icon: Icon(
                          Icons.power_settings_new,
                          color: appColorWhite,
                        ),
                        onPressed: () {
                          scaffoldKey.currentState!.openEndDrawer();
                        },
                      ),
                    ),
                    Image.asset(bu_logo_black),
                    //TODO: Person Details

                    30.height,
                    DrawerItem(
                      "My Profile",
                      Icons.person,
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfileScreen()));
                      },
                    ),
                    15.height,
                    DrawerItem("Checkout", Icons.credit_card),
                    15.height,
                    Obx(
                      () => Container(
                        decoration: BoxDecoration(
                          color: appColorWhite.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: ExpansionTile(
                          title: Row(
                            children: [
                              Icon(
                                Icons.category,
                                size: 24,
                                color: Colors.black54,
                              ),
                              5.width,
                              Text(
                                "CATEGORIES",
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle2!
                                    .copyWith(fontWeight: FontWeight.w600),
                              ),
                            ],
                          ) ,
                          children:
                              productsController.allCategoriesList.map((element) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ViewAllProductScreen(
                                                category: element)));
                              },
                              child: Container(
                                // color: appColorWhite.withOpacity(0.5),
                                padding: EdgeInsets.all(10),
                                child: text(element!.name),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    15.height,
                    DrawerItem(
                        "Billing details", Icons.insert_invitation,
                        onTap: () {
                          goToPage(context, BillingAddress(isOrder: false,));
                        }),
                    15.height,
                    DrawerItem(
                        "Shipping details", Icons.local_shipping_outlined,
                        onTap: () {
                      goToPage(context, ShippingAddress(isOrder: false,));
                    }),
                    15.height,
                    DrawerItem("Orders", Icons.shopping_cart, onTap: () {
                      goToPage(context, OrdersListScreen());
                    }),
                    15.height,
                    DrawerItem("Logout", Icons.login_outlined, onTap: () {
                      scaffoldKey.currentState!.openEndDrawer();
                      account.customerId = "-1";
                      cartController.myCart(MyWooCart());
                      goToPageAndRemove(context, DTSignInScreen());
                    }),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      backgroundColor: appColorBlack,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              color: appColorBlack,
              offset: Offset.fromDirection(3, 1),
              spreadRadius: 1,
              blurRadius: 1)
        ]),
        child: LearnerBottomNavigationBar(
          backgroundColor: appColorWhite.withOpacity(0.1),
          items: const <LearnerBottomNavigationBarItem>[
            LearnerBottomNavigationBarItem(icon: ic_home),
            LearnerBottomNavigationBarItem(icon: ic_cart),
            // LearnerBottomNavigationBarItem(icon: Learner_ic_chart_navigation),
            // LearnerBottomNavigationBarItem(icon: Learner_ic_message_navigation),
            LearnerBottomNavigationBarItem(icon: ic_person),
          ],
          currentIndex: selectedIndex,
          unselectedIconTheme: IconThemeData(color: appColorWhite, size: 24),
          selectedIconTheme: IconThemeData(color: appColorRed, size: 24),
          onTap: _onItemTapped,
          type: LearnerBottomNavigationBarType.fixed,
        ),
      ),
      body: SafeArea(
        child: pages[selectedIndex],
      ),
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
          color: appColorWhite.withOpacity(0.8),
          borderRadius: BorderRadius.circular(6),
        ),
        padding: const EdgeInsets.symmetric(vertical: 13.0, horizontal: 10),
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

/*Drawer*/
