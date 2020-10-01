import 'package:afrinformer/healthguidelinesscreen.dart';
import 'package:afrinformer/light_color.dart';
import 'package:afrinformer/selectcountrydialog.dart';
import 'package:afrinformer/updatesscreen.dart';
import 'package:afrinformer/virustracker.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'homescreen.dart';
import 'newsscreen.dart';

class PageNav extends StatefulWidget {

  @override
  _PageNavState createState() => _PageNavState();

  static GlobalKey bottomNavigationKey = GlobalKey();

  static int currentPage = 0;

  LocalStorage storage = LocalStorage("countries");

  static getPage(int page) {
    switch (page) {
      case 0:
        currentPage = 0;
        return HomeScreen();
      case 1:
        currentPage = 1;
        return UpdatesScreen();
      case 2:
        currentPage = 2;
        return HealthGuidelinesScreen();
      default:
        currentPage = 0;
        return HomeScreen();
    }
  }

}

class _PageNavState extends State<PageNav> {

  loadCountry() async {
    if (await widget.storage.getItem("country") == null) {
      await widget.storage.setItem("country", "Algeria");
    }
  }


  getAppBar(int page, bool isDark, SelectCountryDialog alert, BuildContext context) {
    switch (page) {
      case 0:
        return AppBar(
          title: Text("Overview", style: TextStyle(color: isDark ? Colors.white: Colors.black, fontSize: 26.0)),
          leading: IconButton(icon: Icon(Icons.settings, color: isDark ? Colors.white: Colors.red,), iconSize: 30, onPressed: () {
            showDialog(context: context, builder: (context) => alert, barrierDismissible: true).then((value) => setState(() {}));
          }),
          backgroundColor: isDark ? Colors.black: Colors.white,
          iconTheme: IconThemeData(color: Colors.black, size: 26.0),
        );
        break;
      case 1:
        return AppBar(
          title: Text("Updates in your Country", style: TextStyle(color: isDark ? Colors.white: Colors.black, fontSize: 26.0)),
          leading: IconButton(icon: Icon(Icons.settings, color: isDark ? Colors.white: Colors.red,), iconSize: 30, onPressed: () {
            showDialog(context: context, builder: (context) => alert, barrierDismissible: true).then((value) => setState(() {}));
          }),
          backgroundColor: isDark ? Colors.black: Colors.white,
          iconTheme: IconThemeData(color: Colors.black, size: 26.0),
        );
        break;
      case 2:
        return AppBar(
          title: Text("Health Advice", style: TextStyle(color: isDark ? Colors.white: Colors.black, fontSize: 26.0)),
          leading: IconButton(icon: Icon(Icons.settings, color: isDark ? Colors.white: Colors.red,), iconSize: 30, onPressed: () {
            showDialog(context: context, builder: (context) => alert, barrierDismissible: true).then((value) => setState(() {}));
          }),
          backgroundColor: isDark ? Colors.black: Colors.white,
          iconTheme: IconThemeData(color: Colors.black, size: 26.0),
        );
        break;
      case 3:
        return AppBar(
          title: Text("Subscriptions and Activities", style: TextStyle(color: isDark ? Colors.white: Colors.black, fontSize: 26.0)),
          leading: IconButton(icon: Icon(Icons.settings, color: isDark ? Colors.white: Colors.red,), iconSize: 30, onPressed: () {
            showDialog(context: context, builder: (context) => alert, barrierDismissible: true).then((value) => setState(() {}));
          }),
          backgroundColor: isDark ? Colors.black: Colors.white,
          iconTheme: IconThemeData(color: Colors.black, size: 26.0),
        );
        break;
      default:
        return AppBar(
          title: Text("Home", style: TextStyle(color: isDark ? Colors.white: Colors.black, fontSize: 26.0)),
          leading: IconButton(icon: Icon(Icons.settings, color: isDark ? Colors.white: Colors.red,), iconSize: 30, onPressed: () {
            showDialog(context: context, builder: (context) => alert, barrierDismissible: true).then((value) => setState(() {}));
          }),
          backgroundColor: isDark ? Colors.black: Colors.white,
          iconTheme: IconThemeData(color: Colors.black, size: 26.0),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    loadCountry();

    final Brightness brightnessValue = MediaQuery.of(context).platformBrightness;
    bool isDark = brightnessValue == Brightness.dark;

    final alert = SelectCountryDialog();

    final appBar = getAppBar(PageNav.currentPage, isDark, alert, context);

    final bottomNavigation = FancyBottomNavigation(
      tabs: [
        TabData(iconData: Icons.dashboard, title: ''), // Overview continent wide
        TabData(iconData: Icons.my_location, title: ''), // Facts in your country
        TabData(iconData: Icons.local_hospital, title: ''), // Health
        //TabData(iconData: Icons.subscriptions, title: ''), // Subscriptions and Activities
      ],
      onTabChangedListener: (position) {
        setState(() {
          //Navigator.of(context).pushNamed(SignInScreen.tag);
          PageNav.currentPage = position;
          //Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => PageNav.getPage(position)));
        });
      },
      initialSelection: 0,
      key: PageNav.bottomNavigationKey,
    );

    return Scaffold(
      appBar: appBar,
      body: PageNav.getPage(PageNav.currentPage),
      bottomNavigationBar: bottomNavigation,
    );


  }



}