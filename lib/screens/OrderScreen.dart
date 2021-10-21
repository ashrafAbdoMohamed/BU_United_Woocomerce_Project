import 'package:bu_united_flutter_app/models/billing.dart';
import 'package:bu_united_flutter_app/models/shipping.dart';
import 'package:bu_united_flutter_app/screens/widgets/billing_address_widget.dart';
import 'package:bu_united_flutter_app/screens/widgets/shipping_address_widget.dart';
import 'package:bu_united_flutter_app/utils/AppColors.dart';
import 'package:bu_united_flutter_app/utils/AppWidget.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import 'PaymentScreen.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  _OrderScreenState createState() => _OrderScreenState();
}
Billing? checkOutBilling;
Shipping? checkOutShipping;

class _OrderScreenState extends State<OrderScreen> {
  int currentPage = 1;



  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appColorRed,
        title: text(
          "Checkout",
          textColor: appColorWhite,
        ),
      ),
      body: Container(
        height: height,
        color: appColorBlack,
        child: Column(
          children: [
            checkpoints(),
            Divider(
              color: grey,
              height: 1,
            ),
            10.height,
            Expanded(
              child: SingleChildScrollView(
                  //todo: body that changes,
                  child: (currentPage == 1)
                      ? BillingAddress(
                          isOrder: true,
                          onNext: () {
                            setState(() {
                              currentPage = 2;
                            });
                          },
                        )
                      : (currentPage == 2)
                          ? ShippingAddress(
                              isOrder: true,
                              onNext: () {
                                setState(() {
                                  currentPage = 3;
                                });
                              },
                            )
                          : PaymentScreen(billing: checkOutBilling , shipping: checkOutShipping,)),
            ),
          ],
        ),
      ),
    );
  }

  Widget checkpoints() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          5.width,
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: InkWell(
              onTap: () {
                // setState(() {
                //   currentPage = 1;
                // });
              },
              child: Column(
                children: [
                  /*Container(
                    height: 30,
                    width: 30,
                    child: CircleAvatar(
                      backgroundColor: (currentPage == 1)
                          ? appColorRed
                          : grey.withOpacity(0.3),
                      child: text("1", textColor: white, isCentered: true),
                    ),
                  ),*/
                  5.height,
                  Container(
                    width: width * 0.29,
                    child: text("Billing", textColor: white, isCentered: true),
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 2),
                    decoration: BoxDecoration(
                        color: (currentPage == 1)
                            ? appColorRed
                            : grey.withOpacity(0.3),
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                  ),
                ],
              ),
            ),
          ),
          5.width,
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: InkWell(
              onTap: () {
                // setState(() {
                //   currentPage = 2;
                // });
              },
              child: Column(
                children: [
                  /*Container(
                    height: 30,
                    width: 30,
                    child: CircleAvatar(
                      backgroundColor: (currentPage == 2)
                          ? appColorRed
                          : grey.withOpacity(0.3),
                      child: text("2", textColor: white, isCentered: true),
                    ),
                  ),*/
                  5.height,
                  Container(
                    width: width * 0.29,
                    child: text("Shipping", textColor: white, isCentered: true),
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 2),
                    decoration: BoxDecoration(
                        color: (currentPage == 2)
                            ? appColorRed
                            : grey.withOpacity(0.3),
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                  ),
                ],
              ),
            ),
          ),
          5.width,
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: InkWell(
              onTap: () {
                // setState(() {
                //   currentPage = 3;
                // });
              },
              child: Column(
                children: [
                  /*Container(
                    height: 30,
                    width: 30,
                    child: CircleAvatar(
                      backgroundColor: (currentPage == 3)
                          ? appColorRed
                          : grey.withOpacity(0.3),
                      child: text("3", textColor: white, isCentered: true),
                    ),
                  ),*/
                  5.height,
                  Container(
                    width: width * 0.29,
                    child: text("Payment", textColor: white, isCentered: true),
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 2),
                    decoration: BoxDecoration(
                        color: (currentPage == 3)
                            ? appColorRed
                            : grey.withOpacity(0.3),
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                  ),
                ],
              ),
            ),
          ),
          5.width,
        ],
      ),
    );
  }

  Widget paymentProcess() {
    return Center(child: text("mmm"));
  }
}
