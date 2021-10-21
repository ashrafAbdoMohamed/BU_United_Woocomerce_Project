import 'package:bu_united_flutter_app/controllers/auth_controller.dart';
import 'package:bu_united_flutter_app/controllers/cart_controller.dart';
import 'package:bu_united_flutter_app/controllers/customer_controller.dart';
import 'package:bu_united_flutter_app/controllers/order_controller.dart';
import 'package:bu_united_flutter_app/controllers/products_controller.dart';
import 'package:bu_united_flutter_app/models/customer.dart';
import 'package:bu_united_flutter_app/models/woo/cart.dart';
import 'package:bu_united_flutter_app/screens/OrdersListScreen.dart';
import 'package:bu_united_flutter_app/screens/widgets/billing_address_widget.dart';
import 'package:bu_united_flutter_app/screens/widgets/shipping_address_widget.dart';
import 'package:bu_united_flutter_app/utils/AppColors.dart';
import 'package:bu_united_flutter_app/utils/AppImages.dart';
import 'package:bu_united_flutter_app/utils/AppWidget.dart';
import 'package:bu_united_flutter_app/utils/account.dart';
import 'package:bu_united_flutter_app/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import 'DTSignInScreen.dart';


class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // final customerController = Get.put(CustomerController());
  final authController = Get.put(AuthController());
  final cartController = Get.put(CartController());
  final customerController = Get.put(CustomerController());
  final orderController = Get.put(OrderController());
  final productController = Get.put(ProductsController());
  TextEditingController firstNameCon = TextEditingController();
  TextEditingController lastNameCon = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

      authController
          .getCustomerByID(account.customerId.toString())
          .then((customer) {
        print("returned = " + customer!.avatarUrl.toString());
      });

    if(account.customerId!="-1"){
      firstNameCon.text = authController.loggedInCustomer.value.firstName.toString();
      lastNameCon.text = authController.loggedInCustomer.value.lastName.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(10),
          height: MediaQuery.of(context).size.height,
          color: appColorBlack,
          child: Obx(
            () => (authController.isLoading.value)
                ? Center(child: CircularProgressIndicator())
                :  SingleChildScrollView(
                    child: Container(
                      width: width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          20.height,
                          CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.orange,
                            child: (authController.loggedInCustomer.value.avatarUrl == null ||
                                authController.loggedInCustomer.value.avatarUrl.toString().isEmpty) ?
                              Image.asset(person).cornerRadiusWithClipRRect(50)
                            : Image.network(authController.loggedInCustomer.value.avatarUrl)
                                .cornerRadiusWithClipRRect(50),
                          ),
                          10.height,
                          customRichText(
                              text1: "User name: ",
                              text2: authController.loggedInCustomer.value.username,
                              color1: appColorGrey,
                              color2: appColorWhite,
                              size1: 18,
                              size2: 20),
                          10.height,
                          customRichText(
                              text1: "Email: ",
                              text2:
                              authController.loggedInCustomer.value.email,
                              color1: appColorGrey,
                              color2: appColorWhite,
                              size1: 18,
                              size2: 20),
                          10.height,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                width: width * 0.4,
                                child: whiteEditText("First Name", firstNameCon),
                              ),
                              Container(
                                width: width * 0.4,
                                child: whiteEditText("Last Name", lastNameCon),
                              ),
                            ],
                          ),
                          10.height,
                          Divider(
                            height: 1,
                            color: appShadowColor,
                          ),
                          20.height,
                          InkWell(
                            onTap: (){
                              goToPage(context, OrdersListScreen());
                            },
                            child: Container(
                              color: appColorWhite.withOpacity(0.9),
                              padding: EdgeInsets.all(12),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Icon(Icons.shopping_cart_sharp),
                                      text(" My Orders" , textColor: appColorBlack , fontSize: 20.0),
                                    ],
                                  ),
                                  Icon(Icons.arrow_forward_ios , size: 20, color: appColorBlack,)
                                ],

                              ),
                            ),
                          ),
                          20.height,
                          InkWell(
                            onTap: (){
                              goToPage(context, BillingAddress(isOrder: false,));
                            },
                            child: Container(
                              color: appColorWhite.withOpacity(0.9),
                              padding: EdgeInsets.all(12),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Icon(Icons.payment),
                                      text(" Billing details" , textColor: appColorBlack , fontSize: 20.0),
                                    ],
                                  ),
                                  Icon(Icons.arrow_forward_ios , size: 20, color: appColorBlack,)
                                ],

                              ),
                            ),
                          ),
                          20.height,
                          InkWell(
                            onTap: (){
                              goToPage(context, ShippingAddress(isOrder: false,));
                              },
                            child: Container(
                              color: appColorWhite.withOpacity(0.9),
                              padding: EdgeInsets.all(12),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Icon(Icons.local_shipping_outlined),
                                      text(" Shipping details" , textColor: appColorBlack , fontSize: 20.0),
                                    ],
                                  ),
                                  Icon(Icons.arrow_forward_ios , size: 20, color: appColorBlack,)
                                ],

                              ),
                            ),
                          ),
                          20.height,
                          InkWell(
                            onTap: (){},
                            child: Container(
                              color: appColorWhite.withOpacity(0.9),
                              padding: EdgeInsets.all(12),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Icon(Icons.language),
                                      text(" Change Language" , textColor: appColorBlack , fontSize: 20.0),
                                    ],
                                  ),
                                  Icon(Icons.arrow_forward_ios , size: 20, color: appColorBlack,)
                                ],

                              ),
                            ),
                          ),
                          20.height,
                          InkWell(
                            onTap: (){
                              showConfirmDialog(context, "Are you sure?" , onAccept: (){
                                account.customerId = "-1";
                                cartController.myCart(MyWooCart());
                                orderController.allOrders.clear();
                                authController.loggedInCustomer(Customer());
                                productController.allCategoriesList.clear();

                                goToPageAndRemove(context, DTSignInScreen());
                              });
                            },
                            child: Container(
                              color: appColorWhite.withOpacity(0.9),
                              padding: EdgeInsets.all(12),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Icon(Icons.logout),
                                      text(" Logout" , textColor: appColorBlack , fontSize: 20.0),
                                    ],
                                  ),
                                  Icon(Icons.arrow_forward_ios , size: 20, color: appColorBlack,)
                                ],

                              ),
                            ),
                          ),
                          /*ExpansionTile(
                            collapsedBackgroundColor: appShadowColor.withOpacity(0.3),
                            title: text("Shipping", textColor: Colors.white),
                            children: [
                              ShippingAddress(isOrder: false,),
                            ],
                          ).cornerRadiusWithClipRRect(5),
                          20.height,
                          Divider(
                            height: 1,
                            color: appShadowColor,
                          ),
                          20.height,
                          ExpansionTile(
                            collapsedBackgroundColor: appShadowColor.withOpacity(0.3),
                            title: text("Biling", textColor: Colors.white),
                            children: [
                              BillingAddress(isOrder: false,),
                            ],
                          ).cornerRadiusWithClipRRect(5),*/
                        ],
                      ),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
