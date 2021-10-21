import 'package:bu_united_flutter_app/controllers/auth_controller.dart';
import 'package:bu_united_flutter_app/controllers/order_controller.dart';
import 'package:bu_united_flutter_app/models/simple_order.dart';
import 'package:bu_united_flutter_app/screens/OrderDetailsScreen.dart';
import 'package:bu_united_flutter_app/utils/AppColors.dart';
import 'package:bu_united_flutter_app/utils/AppWidget.dart';
import 'package:bu_united_flutter_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrdersListScreen extends StatefulWidget {
  const OrdersListScreen({Key? key}) : super(key: key);

  @override
  _OrdersListScreenState createState() => _OrdersListScreenState();
}

class _OrdersListScreenState extends State<OrdersListScreen> {
  final ordersController = Get.put(OrderController());
  final authController = Get.put(AuthController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ordersController.getMyOrders(authController.loggedInCustomer.value.email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, 'My Orders'),
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: appColorBlack,
        child: Obx(
          () => (ordersController.isMyOrdersLoading.value)
              ? Center(child: CircularProgressIndicator())
              : (ordersController.isMyOrdersLoading.value == false &&
                      ordersController.allOrders.isEmpty)
                  ? Center(child: text("No orders yet"))
                  : SingleChildScrollView(
                    child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: text("Order",
                                      textColor: appColorWhite,
                                      isBold: true,
                                      fontSize: 20.0),
                                  flex: 1,
                                ),
                                Flexible(
                                  child: text("Details",
                                      textColor: appColorWhite,
                                      isBold: true,
                                      fontSize: 20.0),
                                  flex: 1,
                                ),
                                Flexible(
                                  child: text("Action",
                                      textColor: appColorWhite,
                                      isBold: true,
                                      fontSize: 20.0),
                                  flex: 1,
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            thickness: 1,
                            color: appColorWhite,
                            height: 5,
                          ),
                          ListView.separated(
                            itemCount: ordersController.allOrders.length,
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return OrderItem(
                                  ordersController.allOrders[index]!);
                            },
                            separatorBuilder: (context, index) {
                              return Divider(
                                thickness: 1,
                                color: appColorWhite,
                                height: 5,
                              );
                            },
                          ),
                          Divider(
                            thickness: 1,
                            color: appColorWhite,
                            height: 5,
                          ),
                        ],
                      ),
                  ),
        ),
      ),
    );
  }

  Widget OrderItem(SimpleOrder simpleOrder) {
    return ListTile(
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          text("#${simpleOrder.iD}", textColor: appColorRed, isBold: true),
        ],
      ),
      //leading: text("#${simpleOrder.iD}" , textColor: appColorRed , isBold: true),
      title: Column(
        children: [
          text("${simpleOrder.date}",
              textColor: appColorWhite.withOpacity(0.9)),
          text("${simpleOrder.status}",
              textColor: appColorAccent.withOpacity(0.9)),
          text("${simpleOrder.value.toString().toCurrencyFormat()}",
              textColor: appColorWhite.withOpacity(0.9)),
        ],
      ),
      trailing:
          // Obx(
          //   ()=>
          //(ordersController.isLoading.value) ? Container(width: 80, child: Center(child: CircularProgressIndicator())) :
          appSmallButton(
              label: "View",
              btnWidth: 80,
              onTap: () {
                ordersController
                    .getOrderByNumber(simpleOrder.iD.toString())
                    .then((order) {
                  if (order != null) {
                    goToPage(context, OrderDetailsScreen(order!));
                  }
                });
              }
              // ),
              ),
    );
  }
}
