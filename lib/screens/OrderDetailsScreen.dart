import 'package:bu_united_flutter_app/controllers/order_controller.dart';
import 'package:bu_united_flutter_app/models/order.dart';
import 'package:bu_united_flutter_app/utils/AppColors.dart';
import 'package:bu_united_flutter_app/utils/AppWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';

class OrderDetailsScreen extends StatefulWidget {

  Order order;
  OrderDetailsScreen(this.order);

  @override
  _OrderDetailsScreenState createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  //final ordersController = Get.put(OrderController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, "Order #${widget.order.number}"),
      body: Container(
        color: appColorBlack,
        child: OrderItem(widget.order),
      ),
    );
  }
}

class OrderItem extends StatelessWidget {
  Order order;

  OrderItem(this.order);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(4),
              child: orderRichText(),
            ),
            20.height,
            Container(
              alignment: Alignment.center,
              //color: appColorRed.withOpacity(0.3),
              decoration: BoxDecoration(
                color: appColorRed.withOpacity(0.5),
                borderRadius: BorderRadius.circular(8),
                /*boxShadow: defaultBoxShadow()*/),
              padding: EdgeInsets.only(bottom: 5 , top: 3),
              child: text("Order #${order.number} Details",
                  fontSize: 26.0, textColor: appColorWhite),
              // alignment: Alignment.centerLeft,
            ),
            10.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                text("Products" , textColor: appColorWhite),
                text("Total", textColor: appColorWhite),
              ],
            ),
            Divider(height: 5, thickness: 1, color: appColorGrey,),
            //todo: Items
            Column(
              children: order.lineItems!.map((item) {
                return Column(
                  children: [
                    10.height,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        customRichText(text1: item.name.toString(), text2: "  x " + item.quantity.toString(),
                            color1: appColorRed, color2: appColorWhite.withOpacity(0.8), size1: 20, size2: 18),
                        //text(item.name.toString() + "  x " + item.quantity.toString()),
                        text(item.total.toString().toCurrencyFormat() , textColor: appColorWhite , fontSize: 20.0),

                      ],
                    ),
                    10.height,
                    Divider(height: 5, thickness: 1, color: appColorGrey,),
                  ],
                );
              }).toList(),
            ),

            10.height,
            //todo billing container:
            Container(
              alignment: Alignment.centerLeft,
              //color: appColorRed.withOpacity(0.3),
              decoration: BoxDecoration(
                color: appColorWhite.withOpacity(0.9),
                borderRadius: BorderRadius.circular(8),
                /*boxShadow: defaultBoxShadow()*/),
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  text("Billing address" , textColor: Colors.black , fontSize: 24.0 , isBold: true),
                  10.height,
                  text(order.billing!.firstName.toString() + " " + order.billing!.lastName.toString(),
                      textColor: appColorBlack , fontSize: 20.0 ),
                  (order.billing!.company.toString().isNotEmpty) ? text(order.billing!.company.toString() ,
                      textColor: appColorBlack , fontSize: 20.0 ) : SizedBox(height: 0,),
                  (order.billing!.address1.toString().isNotEmpty) ? text(order.billing!.address1.toString() ,
                      textColor: appColorBlack , fontSize: 20.0 ) : SizedBox(height: 0,),
                  (order.billing!.address2.toString().isNotEmpty) ? text(order.billing!.address2.toString() ,
                      textColor: appColorBlack , fontSize: 20.0 ) : SizedBox(height: 0,),
                  (order.billing!.city.toString().isNotEmpty) ? text(order.billing!.city.toString() ,
                      textColor: appColorBlack , fontSize: 20.0 ) : SizedBox(height: 0,),
                  (order.billing!.state.toString().isNotEmpty) ? text(order.billing!.state.toString() ,
                      textColor: appColorBlack , fontSize: 20.0 ) : SizedBox(height: 0,),
                  (order.billing!.country.toString().isNotEmpty) ? text(order.billing!.country.toString() ,
                      textColor: appColorBlack , fontSize: 20.0 ) : SizedBox(height: 0,),
                  (order.billing!.postcode.toString().isNotEmpty) ? text(order.billing!.postcode.toString() ,
                      textColor: appColorBlack , fontSize: 20.0 ) : SizedBox(height: 0,),
                  (order.billing!.phone.toString().isNotEmpty) ? text(order.billing!.phone.toString() ,
                      textColor: appColorBlack , fontSize: 20.0 ) : SizedBox(height: 0,),
                  (order.billing!.email.toString().isNotEmpty) ? text(order.billing!.email.toString() ,
                      textColor: appColorBlack , fontSize: 20.0 ) : SizedBox(height: 0,),
                  10.height,

                ],
              ),
            ),
            20.height,
            //todo shipping container:
            Container(
              alignment: Alignment.centerLeft,
              //color: appColorRed.withOpacity(0.3),
              decoration: BoxDecoration(
                color: appColorWhite.withOpacity(0.9),
                borderRadius: BorderRadius.circular(8),
                /*boxShadow: defaultBoxShadow()*/),
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  text("Shipping address" , textColor: Colors.black , fontSize: 24.0 , isBold: true),
                  10.height,
                  text(order.shipping!.firstName.toString() + " " + order.billing!.lastName.toString(),
                      textColor: appColorBlack , fontSize: 20.0 ),
                  (order.shipping!.company.toString().isNotEmpty) ? text(order.billing!.company.toString() ,
                      textColor: appColorBlack , fontSize: 20.0 ) : SizedBox(height: 0,),
                  (order.shipping!.address1.toString().isNotEmpty) ? text(order.billing!.address1.toString() ,
                      textColor: appColorBlack , fontSize: 20.0 ) : SizedBox(height: 0,),
                  (order.shipping!.address2.toString().isNotEmpty) ? text(order.billing!.address2.toString() ,
                      textColor: appColorBlack , fontSize: 20.0 ) : SizedBox(height: 0,),
                  (order.billing!.city.toString().isNotEmpty) ? text(order.shipping!.city.toString() ,
                      textColor: appColorBlack , fontSize: 20.0 ) : SizedBox(height: 0,),
                  (order.billing!.state.toString().isNotEmpty) ? text(order.shipping!.state.toString() ,
                      textColor: appColorBlack , fontSize: 20.0 ) : SizedBox(height: 0,),
                  (order.billing!.country.toString().isNotEmpty) ? text(order.shipping!.country.toString() ,
                      textColor: appColorBlack , fontSize: 20.0 ) : SizedBox(height: 0,),
                  (order.billing!.postcode.toString().isNotEmpty) ? text(order.shipping!.postcode.toString() ,
                      textColor: appColorBlack , fontSize: 20.0 ) : SizedBox(height: 0,),
                  10.height,

                ],
              ),
            ),
            10.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                text("Subtotal:" , textColor: appColorWhite , fontSize: 20.0),
                text(getTotalPrices(order.lineItems!).toCurrencyFormat() , isBold: true,
                    textColor: appColorWhite , fontSize: 24.0),
              ],
            ),
            10.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                text("Payment method:" , textColor: appColorWhite , fontSize: 20.0),
                text(order.paymentMethodTitle.toString() , isBold: true,
                    textColor: appColorWhite , fontSize: 20.0),
              ],
            ),
            50.height,
          ],
        ),
      ),
    );
  }

  String getTotalPrices(List<LineItems> items){
    int total = 0;
    for(int i = 0 ; i < items.length ; i++){
      total += int.parse(items[i].total.toString());
    }
    return total.toString();
  }

  orderRichText() {
    return RichText(
        text: TextSpan(
            style: TextStyle(
              fontSize: 16,
            ),
            children: [
          TextSpan(
              text: "Order ",
              style: TextStyle(
                color: appColorGrey,
              )),
          TextSpan(
              text: "#${order.number} ",
              style:
                  TextStyle(color: appColorWhite, fontWeight: FontWeight.bold)),
          TextSpan(
              text: "was placed on ",
              style: TextStyle(
                color: appColorGrey,
              )),
          TextSpan(
              text: order.dateCreated.toString().split(" ")[1]  ,
              style:
                  TextStyle(color: appColorWhite, fontWeight: FontWeight.bold)),
          TextSpan(
              text: " and is currently ",
              style: TextStyle(
                color: appColorGrey,
              )),
          TextSpan(
              text: "${order.status}. ",
              style:
                  TextStyle(color: appColorWhite, fontWeight: FontWeight.bold)),
          TextSpan(
              text: "Payment method: ",
              style: TextStyle(
                color: appColorGrey,
              )),
          TextSpan(
              text: "${order.paymentMethodTitle} ",
              style:
                  TextStyle(color: appColorWhite, fontWeight: FontWeight.bold)),
        ]));
  }
}
