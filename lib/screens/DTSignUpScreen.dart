import 'package:bu_united_flutter_app/controllers/auth_controller.dart';
import 'package:bu_united_flutter_app/models/customer.dart';
import 'package:bu_united_flutter_app/utils/AppColors.dart';
import 'package:bu_united_flutter_app/utils/AppConstant.dart';
import 'package:bu_united_flutter_app/utils/AppWidget.dart';
import 'package:bu_united_flutter_app/utils/account.dart';
import 'package:bu_united_flutter_app/utils/utils.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'DTSignInScreen.dart';
import 'HomeDashboard.dart';
import 'HomeScreen.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DTSignUpScreen extends StatefulWidget {
  static String tag = '/DTSignUpScreen';

  @override
  DTDTSignUpScreen createState() => DTDTSignUpScreen();
}

class DTDTSignUpScreen extends State<DTSignUpScreen> {
  var formKey = GlobalKey<FormState>();
  bool obscureText = true;
  bool autoValidate = false;

  var emailCont = TextEditingController();

  final authController = Get.put(AuthController());

  var passFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appBar(context, 'Register'),
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
                  requiredTextFieldRichText("Email Address"),
                  5.height,
                  TextFormField(
                    controller: emailCont,
                    style: primaryTextStyle( color: appColorBlack),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: boxBackgroundColor,
                      contentPadding: EdgeInsets.all(16),
                      labelStyle: secondaryTextStyle(),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0), borderSide: BorderSide(color: appColorRed)),
                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0), borderSide: BorderSide(color: appColorBlack)),
                    ),
                    keyboardType: TextInputType.emailAddress,

                    onFieldSubmitted: (s) => FocusScope.of(context).requestFocus(passFocus),
                    textInputAction: TextInputAction.next,
                  ),

                  20.height,
                  Obx(
                    () => (authController.isLoading.value)
                        ? Center(
                      child: CircularProgressIndicator(),
                    ) :  appSmallButton(label: "Register" ,onTap: (){
                      if(emailCont.text.isEmpty ){
                        /*snackBar(context , content: text("Enter all required fields" , textColor: Colors.white , fontSize: textSizeMedium),
                            title: "Error: ");*/
                        createToast("Enter all required fields" , false);
                      }else {
                        String generatedPass = getRandomString(8);
                        authController.registerCustomer(
                            customer: Customer(email: emailCont.text , password: generatedPass),
                            onFailed: (msg) {
                              createToast(msg , false);
                            }
                        ).then((customer) {
                            if(customer!=null){
                              authController.sendPasswordViaMail(email: emailCont.text, pass: generatedPass,
                                ).then((msg) {
                                    if(msg!.contains("Your password has been sent")){
                                      goToPageAndRemove(context, DTSignInScreen());
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) => CustomDialog(title: welcomeTitle ,text: welcomeText),
                                      );
                                    }else{
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) => CustomDialog(title: welcomeTitle ,text: welcomeErrorText),
                                      );
                                    }
                              });

                            }
                           

                        });
                      }
                    } , btnWidth: MediaQuery.of(context).size.width ),
                  ),
                  10.height,
                  Container(
                    padding: EdgeInsets.only(top: 8, bottom: 8),
                    alignment: Alignment.topLeft,
                    child: text(sign_up_screen_text_1, textColor: Colors.white , fontSize: textSizeMedium , maxLine: 2),
                  ),
                  10.height,
                  GestureDetector(
                    onTap: (){
                      print("Signup");
                    },
                    child: RichText(text: TextSpan(
                      style: TextStyle(fontSize: 16 , ),
                      children: [
                        TextSpan(text: sign_up_screen_text_2 , style: TextStyle(color: Colors.white )),
                        TextSpan(text: sign_up_screen_text_3 , style: TextStyle(color: appColorRed) ),
                      ]
                    )),
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
