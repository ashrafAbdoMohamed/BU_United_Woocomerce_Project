import 'package:bu_united_flutter_app/controllers/auth_controller.dart';
import 'package:bu_united_flutter_app/controllers/customer_controller.dart';
import 'package:bu_united_flutter_app/models/billing.dart';
import 'package:bu_united_flutter_app/models/customer.dart';
import 'package:bu_united_flutter_app/utils/AppColors.dart';
import 'package:bu_united_flutter_app/utils/AppWidget.dart';
import 'package:bu_united_flutter_app/utils/account.dart';
import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:bu_united_flutter_app/screens/OrderScreen.dart';

class BillingAddress extends StatefulWidget {
  bool? isOrder = false;
  Function? onNext;

  BillingAddress({this.isOrder, this.onNext});

  @override
  State<BillingAddress> createState() => _BillingAddressState();
}

class _BillingAddressState extends State<BillingAddress> {
  TextEditingController firstNameCon = TextEditingController();
  TextEditingController lastNameCon = TextEditingController();
  TextEditingController companyNameCon = TextEditingController();
  TextEditingController streetAddressCon = TextEditingController();
  TextEditingController address2Con = TextEditingController();
  TextEditingController countryCon = TextEditingController();
  TextEditingController stateCon = TextEditingController();
  TextEditingController cityCon = TextEditingController();
  TextEditingController pinCodeCon = TextEditingController();
  TextEditingController emailCon = TextEditingController();
  TextEditingController phoneCon = TextEditingController();

  final authController = Get.put(AuthController());
  final customerController = Get.put(CustomerController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (account.customerId != "-1") {
      firstNameCon.text =
          authController.loggedInCustomer.value.billing!.firstName ?? "";
      lastNameCon.text =
          authController.loggedInCustomer.value.billing!.lastName ?? "";
      companyNameCon.text =
          authController.loggedInCustomer.value.billing!.company ?? "";
      streetAddressCon.text =
          authController.loggedInCustomer.value.billing!.address1 ?? "";
      address2Con.text =
          authController.loggedInCustomer.value.billing!.address2 ?? "";
      countryCon.text =
          authController.loggedInCustomer.value.billing!.country ?? "";
      stateCon.text =
          authController.loggedInCustomer.value.billing!.state ?? "";
      cityCon.text = authController.loggedInCustomer.value.billing!.city ?? "";
      pinCodeCon.text =
          authController.loggedInCustomer.value.billing!.postcode ?? "";
      emailCon.text = authController.loggedInCustomer.value.billing!.email == ""
          ? authController.loggedInCustomer.value.email
          : authController.loggedInCustomer.value.billing!.email;
      phoneCon.text =
          authController.loggedInCustomer.value.billing!.phone ?? "";
    }
  }
  String? countryValue = "";
  String? stateValue = "";
  String? cityValue = "";

  @override
  Widget build(BuildContext context) {

    return (widget.isOrder == false) ?
    Scaffold(
      appBar: appBar(context, "Billing details"),
      body: SafeArea(
        child: billingBody(),
      ),
    ) : billingBody() ;
  }

  Widget billingBody(){
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      color: appColorBlack,
      width: width ,
      height: height ,
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
            /*requiredTextFieldRichText("Country/region"),
                whiteEditText("", countryCon),
                requiredTextFieldRichText("State"),
                whiteEditText("", stateCon),
                requiredTextFieldRichText("Town/city"),
                whiteEditText("", cityCon),*/
            Row(
              children: [
                Flexible(
                  flex: 1,
                  child:  requiredTextFieldRichText("Country/region"),
                ),
                Flexible(
                  flex: 1,
                  child:  requiredTextFieldRichText("State / City"),
                ),
              ],
            ),
            CSCPicker(
              onCountryChanged: (value) {
                setState(() {
                  countryValue = value;
                });
              },
              onStateChanged:(value) {
                setState(() {
                  stateValue = value;
                });
              },
              onCityChanged:(value) {
                setState(() {
                  cityValue = value;
                });
              },
            ),
            5.height,
            requiredTextFieldRichText("Street address"),
            whiteEditText("", streetAddressCon),
            requiredTextFieldRichText("Pin code"),
            whiteEditText("", pinCodeCon, textInputType: TextInputType.number),
            requiredTextFieldRichText("Phone"),
            whiteEditText("", phoneCon, textInputType: TextInputType.phone),
            requiredTextFieldRichText("Email address"),
            whiteEditText("", emailCon,
                textInputType: TextInputType.emailAddress),
            (widget.isOrder == false)
                ? Obx(
                  () => (customerController.isLoading.value)
                  ? Center(child: CircularProgressIndicator())
                  : appSmallButton(
                  label: "Save",
                  btnWidth: width * 0.5,
                  onTap: () {
                    customerController
                        .updateCustomerBilling(Customer(
                      id: account.customerId,
                      billing: Billing(
                        firstName: firstNameCon.text,
                        lastName: lastNameCon.text,
                        company: companyNameCon.text,
                        address1: streetAddressCon.text,
                        address2: address2Con.text,
                        city: cityCon.text,
                        postcode: pinCodeCon.text,
                        country: countryCon.text,
                        state: stateCon.text,
                        email: emailCon.text,
                        phone: phoneCon.text,
                      ),
                    ))
                        .then((value) {
                      if (value != null) {
                        authController
                            .getCustomerByID(account.customerId.toString())
                            .then((customer){
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
              child: appSmallButton(
                  label: "Next",
                  onTap: () {
                    if(validInfo()){
                      checkOutBilling = Billing(
                          firstName: firstNameCon.text,
                          lastName: lastNameCon.text,
                          email: emailCon.text,
                          address1:  streetAddressCon.text,
                          address2:  "",
                          city: cityValue,
                          company: companyNameCon.text,
                          country: countryValue,
                          state: stateValue,
                          phone: phoneCon.text,
                          postcode: pinCodeCon.text
                      );
                      widget.onNext!();
                    }

                  },
                  btnWidth: width * 0.3),
            ),
            10.height,
          ],
        ),
      ),
    );
  }

  bool validInfo() {

    if(firstNameCon.text.isEmpty || lastNameCon.text.isEmpty || streetAddressCon.text.isEmpty
     || pinCodeCon.text.isEmpty || phoneCon.text.isEmpty || emailCon.text.isEmpty
     || countryValue!.isEmpty || stateValue!.isEmpty || cityValue!.isEmpty  ){
      snackBar(context , title: "Please enter all required data", behavior: SnackBarBehavior.floating);
      return false;
    }else if(!emailCon.text.isEmail){
      snackBar(context , title: "Please enter a valid email", behavior: SnackBarBehavior.floating);
      return false;
    }
    return true;
  }
}
