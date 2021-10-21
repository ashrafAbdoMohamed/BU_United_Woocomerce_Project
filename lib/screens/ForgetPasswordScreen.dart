import 'package:bu_united_flutter_app/controllers/auth_controller.dart';
import 'package:bu_united_flutter_app/utils/AppColors.dart';
import 'package:bu_united_flutter_app/utils/AppConstant.dart';
import 'package:bu_united_flutter_app/utils/AppWidget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

class ForgetPasswordScreen extends StatefulWidget {
  static String tag = '/DTSignUpScreen';

  @override
  DTDTSignUpScreen createState() => DTDTSignUpScreen();
}

class DTDTSignUpScreen extends State<ForgetPasswordScreen> {
  var formKey = GlobalKey<FormState>();
  bool obscureText = true;
  bool autoValidate = false;

  var emailCont = TextEditingController();
  var passCont = TextEditingController();

  var passFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    //
  }

  final authController = Get.put(AuthController());

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appBar(context, 'Reset your password'),
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
                  Container(
                    padding: EdgeInsets.only(top: 8, bottom: 8),
                    alignment: Alignment.topLeft,
                    child: text(forget_password_screen_text_1,
                        textColor: Colors.white,
                        fontSize: textSizeMedium,
                        maxLine: 5),
                  ),
                  30.height,
                  requiredTextFieldRichText("Email address"),
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

                  20.height,
                  Obx(
                    () => (authController.isLoading.value)
                        ? Center(child: CircularProgressIndicator())
                        : appSmallButton(
                            label: "Reset Password",
                            btnWidth: MediaQuery.of(context).size.width,
                            onTap: () {
                              if (emailCont.text.isNotEmpty) {
                                authController
                                    .resetPassword(
                                        email: emailCont.text)
                                    .then((msg) {
                                  snackBar(context, title: msg.toString());
                                  if(msg!.contains("Password reset link has been sent")){
                                    Navigator.of(context).pop();
                                  }
                                });
                              } else {
                                snackBar(context,
                                    title: "Please enter your email");
                              }
                            }),
                  ),
                ],
              ),
            ),
          ).center(),
        ),
      ),
    );
  }
}
