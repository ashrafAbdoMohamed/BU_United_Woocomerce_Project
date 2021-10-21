import 'package:bu_united_flutter_app/utils/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class MWDrawerScreen2 extends StatefulWidget {
  static String tag = '/MWDrawerScreen2';

  @override
  _MWDrawerScreen2State createState() => _MWDrawerScreen2State();
}

class _MWDrawerScreen2State extends State<MWDrawerScreen2> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    await Future.delayed(Duration(seconds: 1));
    scaffoldKey.currentState!.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: appColorBlack,
        title: Text('With Custom Shape', style: TextStyle(color: appColorBlack, fontSize: 22)),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            scaffoldKey.currentState!.openDrawer();
          },
        ),
      ),
      drawer: ClipPath(
        clipper: OvalRightBorderClipper(),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Drawer(
          child: Container(
            padding: const EdgeInsets.only(left: 16.0, right: 40),
            decoration: BoxDecoration(
              color: appColorWhite,
            ),
            width: 300,
            child: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        icon: Icon(
                          Icons.power_settings_new,
                          color: appColorWhite,
                        ),
                        onPressed: () {
                          scaffoldKey.currentState!.openEndDrawer();
                        },
                      ),
                    ),
                    Container(
                      height: 90,
                      width: 90,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(width: 2, color: Colors.orange),
                        /*image: DecorationImage(image: CachedNetworkImageProvider('https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTD8u1Nmrk78DSX0v2i_wTgS6tW5yvHSD7o6g&usqp=CAU')),*/
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Text(
                      "John Dow",
                      style: TextStyle(color: appColorWhite, fontSize: 18.0, fontWeight: FontWeight.w600),
                    ),
                    Text("JohnDoe@gmail.com", style: TextStyle(color: appColorWhite, fontSize: 16.0)),
                    30.height,
                    itemList(Icon(Icons.home, color: appColorWhite), "Home"),
                    Divider(),
                    15.height,
                    itemList(Icon(Icons.person_pin, color: appColorWhite), "My profile"),

                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      body: MaterialButton(
        onPressed: () {
          scaffoldKey.currentState!.openDrawer();
        },
        child: Text('Open Drawer', style: primaryTextStyle(color: whiteColor)),
        padding: EdgeInsets.all(16),
        color: appColorWhite,
      ).center(),
    );
  }

  Widget itemList(Widget icon, String title) {
    return Row(
      children: [
        icon,
        10.width,
        Text(title, style: TextStyle(color: appColorWhite)),
      ],
    ).onTap(() {
      scaffoldKey.currentState!.openEndDrawer();
      toast(title);
    });
  }
}

class OvalRightBorderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, 0);
    path.lineTo(size.width - 50, 0);
    path.quadraticBezierTo(size.width, size.height / 4, size.width, size.height / 2);
    path.quadraticBezierTo(size.width, size.height - (size.height / 4), size.width - 40, size.height);
    path.lineTo(0, size.height);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
