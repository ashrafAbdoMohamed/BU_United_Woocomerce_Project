import 'package:bu_united_flutter_app/screens/DTSignInScreen.dart';
import 'package:bu_united_flutter_app/screens/DTSignUpScreen.dart';
import 'package:bu_united_flutter_app/screens/ForgetPasswordScreen.dart';
import 'package:bu_united_flutter_app/screens/HomeScreen.dart';
import 'package:bu_united_flutter_app/screens/MWDrawerScreen2.dart';
import 'package:bu_united_flutter_app/screens/SplashScreen.dart';
import 'package:bu_united_flutter_app/utils/AppColors.dart';
import 'package:bu_united_flutter_app/utils/account.dart';
import 'package:flutter/material.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await account.getPreferences();


  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BU United Internet',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        accentColor: appColorRed,
        fontFamily: 'Roboto',
        brightness: Brightness.light,
        primaryColor: appColorBlack, //Changing this will change the color of the TabBar
        primarySwatch: Colors.red,
      ),
      home: SplashScreen(),
    );
  }
}


