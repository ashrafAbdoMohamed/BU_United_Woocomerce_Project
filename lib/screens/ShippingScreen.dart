import 'package:bu_united_flutter_app/controllers/auth_controller.dart';
import 'package:bu_united_flutter_app/screens/widgets/shipping_address_widget.dart';
import 'package:bu_united_flutter_app/utils/AppColors.dart';
import 'package:bu_united_flutter_app/utils/AppWidget.dart';
import 'package:bu_united_flutter_app/utils/account.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShippingScreen extends StatefulWidget {
  const ShippingScreen({Key? key}) : super(key: key);

  @override
  _ShippingScreenState createState() => _ShippingScreenState();
}

class _ShippingScreenState extends State<ShippingScreen> {
  final authController = Get.put(AuthController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    authController
        .getCustomerByID(account.customerId.toString())
        .then((customer) {
        });
  }
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: appBar(context, "Shipping Details"),
      body: Container(
        padding: EdgeInsets.all(10),
        color: appColorBlack,
        height: height,
        width: width,
        child: Obx(
            () =>
            (authController.isLoading.value)
                ? Center(child: text("Loading..."))
                : ShippingAddress(),
        ),
      ),

    );
  }
}
