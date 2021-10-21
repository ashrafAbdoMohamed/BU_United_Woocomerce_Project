import 'dart:async';

import 'package:bu_united_flutter_app/controllers/auth_controller.dart';
import 'package:bu_united_flutter_app/models/customer.dart';
import 'package:bu_united_flutter_app/utils/AppColors.dart';
import 'package:bu_united_flutter_app/utils/AppImages.dart';
import 'package:bu_united_flutter_app/utils/account.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import 'DTSignInScreen.dart';
import 'HomeDashboard.dart';
import 'HomeScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  final authController = Get.put(AuthController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bool isLoading = false;
    if(account.customerId != "-1"){
      isLoading = true;
      authController.getCustomerByID(account.customerId).then((value) {
        isLoading = false;
        Timer(
            Duration(seconds: 2),
                () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) =>  HomeDashboard() )));
      }).timeout(Duration(seconds: 15) ,onTimeout: (){
        snackBar(context , title: "Timeout: Refresh the app");
      });
    }else{
      Timer(
          Duration(seconds: 3),
              () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) =>  DTSignInScreen() )));
    }


  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      color: appColorBlack,
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width-100,
          height: MediaQuery.of(context).size.width-100,
          child: Image.asset(bu_logo_black),
        ),
      ),
    );
  }
}
