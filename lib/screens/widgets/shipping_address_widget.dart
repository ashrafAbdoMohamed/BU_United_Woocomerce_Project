import 'package:bu_united_flutter_app/controllers/auth_controller.dart';
import 'package:bu_united_flutter_app/controllers/customer_controller.dart';
import 'package:bu_united_flutter_app/models/customer.dart';
import 'package:bu_united_flutter_app/models/shipping.dart';
import 'package:bu_united_flutter_app/screens/OrderScreen.dart';
import 'package:bu_united_flutter_app/utils/AppColors.dart';
import 'package:bu_united_flutter_app/utils/AppWidget.dart';
import 'package:bu_united_flutter_app/utils/account.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

class ShippingAddress extends StatefulWidget {
  bool? isOrder = false;
  Function? onNext;

  ShippingAddress({this.isOrder, this.onNext});

  @override
  State<ShippingAddress> createState() => _ShippingAddressState();
}

class _ShippingAddressState extends State<ShippingAddress> {
  TextEditingController firstNameCon = TextEditingController();
  TextEditingController lastNameCon = TextEditingController();
  TextEditingController companyNameCon = TextEditingController();
  TextEditingController streetAddressCon = TextEditingController();
  TextEditingController address2Con = TextEditingController();
  TextEditingController countryCon = TextEditingController();
  TextEditingController stateCon = TextEditingController();
  TextEditingController cityCon = TextEditingController();
  TextEditingController pinCodeCon = TextEditingController();

  final authController = Get.put(AuthController());
  final customerController = Get.put(CustomerController());
  String? countryValue = "";
  String? stateValue = "";
  String? cityValue = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (account.customerId != "-1") {
      firstNameCon.text =
          authController.loggedInCustomer.value.shipping!.firstName ?? "";
      lastNameCon.text =
          authController.loggedInCustomer.value.shipping!.lastName ?? "";
      companyNameCon.text =
          authController.loggedInCustomer.value.shipping!.company ?? "";
      streetAddressCon.text =
          authController.loggedInCustomer.value.shipping!.address1 ?? "";
      address2Con.text =
          authController.loggedInCustomer.value.shipping!.address2 ?? "";
      countryCon.text =
          authController.loggedInCustomer.value.shipping!.country ?? "";
      stateCon.text =
          authController.loggedInCustomer.value.shipping!.state ?? "";
      cityCon.text = authController.loggedInCustomer.value.shipping!.city ?? "";
      pinCodeCon.text =
          authController.loggedInCustomer.value.shipping!.postcode ?? "";
      countryValue = authController.loggedInCustomer.value.shipping!.country;
    }
  }

  bool checkValue = false;
  bool billingAsShipping = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return (widget.isOrder == false)
        ? Scaffold(
            appBar: appBar(context, "Shipping details"),
            body: Container(height: height, color: appColorBlack, child: shippingBody()),
          )
        : Column(
            children: [
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Checkbox(
                        value: checkValue,
                        onChanged: (bool? value) {
                          setState(() {
                            checkValue = value!;
                            setShippingAddressAsBillingAddress();
                            if(value == true) billingAsShipping = true;
                            else billingAsShipping = false;
                          });
                        },
                      ),
                      10.width,
                      text('Same Address as Billing?',
                          fontSize: 18.0, textColor: appColorWhite),
                      10.width,
                      (billingAsShipping)
                          ? Container(
                              alignment: Alignment.centerRight,
                              child: appSmallButton(
                                  label: "Next",
                                  onTap: () {
                                    if (billingAsShipping) {
                                      widget.onNext!();
                                    }
                                  },
                                  btnWidth: width * 0.2),
                            )
                          : SizedBox(),

                    ], //<Widget>[]
                  ),
                ],
              ), //R
              (checkValue) ? SizedBox() : shippingBody(),
            ],
          );
  }

  Widget shippingBody() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      color: appColorBlack,
      width: width,
      // height: height ,
      padding: EdgeInsets.all(8),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: width * 0.4,
                  child: Column(
                    children: [
                      requiredTextFieldRichText("First Name"),
                      whiteEditText("", firstNameCon),
                    ],
                  ),
                ),
                Container(
                  width: width * 0.4,
                  child: Column(
                    children: [
                      requiredTextFieldRichText("Last Name"),
                      whiteEditText("", lastNameCon),
                    ],
                  ),
                ),
              ],
            ),
            Container(
                alignment: Alignment.centerLeft,
                child: Text("Company name (Optional)",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ))),
            whiteEditText("", companyNameCon),
            5.height,
            Row(
              children: [
                Flexible(
                  flex: 1,
                  child: requiredTextFieldRichText("Country/region"),
                ),
                Flexible(
                  flex: 1,
                  child: requiredTextFieldRichText("State / City"),
                ),
              ],
            ),
            CSCPicker(
              // defaultCountry: DefaultCountry.United_States,
              onCountryChanged: (value) {
                setState(() {
                  countryValue = value;
                });
              },
              onStateChanged: (value) {
                setState(() {
                  stateValue = value;
                });
              },
              onCityChanged: (value) {
                setState(() {
                  cityValue = value;
                });
              },
            ),
            10.height,
            requiredTextFieldRichText("Street address"),
            whiteEditText("", streetAddressCon),
            requiredTextFieldRichText("Pin code"),
            whiteEditText("", pinCodeCon, textInputType: TextInputType.number),
            (widget.isOrder == false)
                ? Obx(
                    () => (customerController.isLoading.value)
                        ? Center(child: CircularProgressIndicator())
                        : appSmallButton(
                            label: "Save",
                            btnWidth: width * 0.5,
                            onTap: () {
                              customerController
                                  .updateCustomerShipping(Customer(
                                id: account.customerId,
                                shipping: Shipping(
                                  firstName: firstNameCon.text,
                                  lastName: lastNameCon.text,
                                  company: companyNameCon.text,
                                  address1: streetAddressCon.text,
                                  address2: address2Con.text,
                                  city: cityCon.text,
                                  postcode: pinCodeCon.text,
                                  country: countryCon.text,
                                ),
                              ))
                                  .then((value) {
                                if (value != null) {
                                  authController
                                      .getCustomerByID(
                                          account.customerId.toString())
                                      .then((customer) {
                                    Navigator.of(context).pop();
                                  });
                                  snackBar(context,
                                      title: "Data Updated",
                                      behavior: SnackBarBehavior.floating);
                                }
                              });
                            }),
                  )
                : Align(
                    alignment: Alignment.centerRight,
                    child: Visibility(
                      visible: true,
                      child: appSmallButton(
                          label: "Next",
                          onTap: () {
                            if (billingAsShipping) {
                              widget.onNext!();
                            } else {
                              if (validInfo()) {
                                checkOutShipping = Shipping(
                                  firstName: firstNameCon.text,
                                  lastName: lastNameCon.text,
                                  company: companyNameCon.text,
                                  address1: streetAddressCon.text,
                                  address2: address2Con.text,
                                  city: cityValue,
                                  postcode: pinCodeCon.text,
                                  country: countryValue,
                                );
                                widget.onNext!();
                              }
                            }
                          },
                          btnWidth: width * 0.3),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  bool validInfo() {
    if (firstNameCon.text.isEmpty ||
        lastNameCon.text.isEmpty ||
        streetAddressCon.text.isEmpty ||
        pinCodeCon.text.isEmpty ||
        countryValue!.isEmpty ||
        stateValue!.isEmpty ||
        cityValue!.isEmpty) {
      snackBar(context,
          title: "Please enter all required data",
          behavior: SnackBarBehavior.floating);
      return false;
    }
    return true;
  }

  void setShippingAddressAsBillingAddress() {
    checkOutShipping = Shipping(
      firstName: checkOutBilling!.firstName,
      lastName: checkOutBilling!.lastName,
      company: checkOutBilling!.company,
      address1: checkOutBilling!.address1,
      address2: checkOutBilling!.address2,
      city: checkOutBilling!.city,
      postcode: checkOutBilling!.postcode,
      country: checkOutBilling!.country,
    );
  }
}
