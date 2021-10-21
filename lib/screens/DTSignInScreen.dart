import 'package:bu_united_flutter_app/controllers/auth_controller.dart';
import 'package:bu_united_flutter_app/screens/DTSignUpScreen.dart';
import 'package:bu_united_flutter_app/screens/ForgetPasswordScreen.dart';
import 'package:bu_united_flutter_app/screens/HomeDashboard.dart';
import 'package:bu_united_flutter_app/screens/HomeScreen.dart';
import 'package:bu_united_flutter_app/utils/AppColors.dart';
import 'package:bu_united_flutter_app/utils/AppConstant.dart';
import 'package:bu_united_flutter_app/utils/AppWidget.dart';
import 'package:bu_united_flutter_app/utils/account.dart';
import 'package:bu_united_flutter_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

class DTSignInScreen extends StatefulWidget {
  static String tag = '/DTSignInScreen';

  @override
  DTSignInScreenState createState() => DTSignInScreenState();
}

class DTSignInScreenState extends State<DTSignInScreen> {
  var formKey = GlobalKey<FormState>();
  bool obscureText = true;
  bool autoValidate = false;

  var emailCont = TextEditingController();
  var passCont = TextEditingController();

  var passFocus = FocusNode();

  final authController = Get.put(AuthController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (account.customerId == "-1") {
      print("customer = null");
    } else {
      print("NN customer = " + account.customerId.toString());
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appBar(context, 'Login'),
      body: Center(
        child: Container(
          color: appColorBlack,
          child: Form(
            key: formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Text('Sign In', style: boldTextStyle(size: 24, color: appTextColorWhite)),
                  // 30.height,
                  requiredTextFieldRichText("Username or email address"),
                  5.height,
                  TextFormField(
                    controller: emailCont,
                    style: primaryTextStyle(color: appColorBlack),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: boxBackgroundColor,
                      contentPadding: EdgeInsets.all(16),
                      labelStyle: secondaryTextStyle(),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide(color: appColorRed)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide(color: appColorBlack)),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    onFieldSubmitted: (s) =>
                        FocusScope.of(context).requestFocus(passFocus),
                    textInputAction: TextInputAction.next,
                  ),
                  10.height,
                  requiredTextFieldRichText("Password"),
                  5.height,
                  TextFormField(
                    obscureText: obscureText,
                    focusNode: passFocus,
                    controller: passCont,
                    style: primaryTextStyle(color: appColorBlack),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: boxBackgroundColor,
                      contentPadding: EdgeInsets.all(16),
                      labelStyle: secondaryTextStyle(),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide(color: appColorRed)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide(color: appColorBlack)),
                      suffix: Icon(!obscureText
                              ? Icons.visibility
                              : Icons.visibility_off)
                          .onTap(() {
                        obscureText = !obscureText;
                        setState(() {});
                      }),
                    ),
                    validator: (s) {
                      if (s!.trim().isEmpty) return errorThisFieldRequired;
                      return null;
                    },
                  ),
                  20.height,
                  Obx(
                    () => (authController.isLoading.value)
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : appSmallButton(
                            label: "Login",
                            onTap: () {
                              if (emailCont.text.isEmpty ||
                                  passCont.text.isEmpty) {
                                snackBar(context,
                                    content: text("Enter all required fields",
                                        textColor: Colors.white,
                                        fontSize: textSizeMedium),
                                    title: "Error: ");
                              } else {
                                authController
                                    .customerLogin(
                                        emailOrUserName: emailCont.text,
                                        password: passCont.text,
                                        onFailed: (msg) {
                                          snackBar(context,
                                              content: text(msg,
                                                  textColor: Colors.white,
                                                  fontSize: textSizeSmall),
                                              title: msg);
                                        })
                                    .then((customer) {
                                      print("logged CCC = "  + customer!.token.toString());
                                      print("logged EEE = "  + customer!.email.toString());
                                      print("logged id = "  + customer!.id.toString());
                                  snackBar(context,
                                      content: text(
                                          "welcome: " + customer!.niceName,
                                          textColor: Colors.white),
                                      title: "msg");
                                  account.customerId = customer.id.toString() ;
                                  account.customerToken = customer.token.toString() ;
                                  account.pass = passCont.text ;
                                  print(account.customerId);
                                  print(account.customerToken);
                                  authController.getCustomerByID(account.customerId).then((value) {
                                    goToPageAndRemove(context, HomeDashboard());
                                  });
                                });
                              }
                            },
                            btnWidth: MediaQuery.of(context).size.width),
                  ),
                  10.height,
                  GestureDetector(
                    onTap: () {
                      print("forget password");
                      goToPage(context, ForgetPasswordScreen());
                    },
                    child: Container(
                      padding: EdgeInsets.only(top: 8, bottom: 8),
                      alignment: Alignment.topLeft,
                      child: text("Lost your Password?",
                          textColor: appColorRed, fontSize: textSizeMedium),
                    ),
                  ),
                  10.height,
                  GestureDetector(
                    onTap: () {
                      print("Signup");
                      goToPage(context, DTSignUpScreen());
                    },
                    child: RichText(
                        text: TextSpan(
                            style: TextStyle(
                              fontSize: 18,
                            ),
                            children: [
                          TextSpan(
                              text: "You don\'t have an account yet?",
                              style: TextStyle(color: Colors.white)),
                          TextSpan(
                              text: ' Sign Up',
                              style: TextStyle(color: appColorRed)),
                        ])),
                  )
                ],
              ),
            ),
          ).center(),
        ),
      ),
    );
  }
}
