import 'package:afrinformer/pagenav.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  // This widget is the root of your application.
  LocalStorage storage = LocalStorage("countries");

  @override
  Widget build(BuildContext context) {

    loadCountry() async {
      if (await storage.getItem("country") == null) {
        await storage.setItem("country", "Algeria");
      }
    }

    loadCountry();

    return MaterialApp(
      title: 'AfrInformer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        brightness: Brightness.light,
        primarySwatch: Colors.red,
      ),
      darkTheme: ThemeData(
          brightness: Brightness.dark
      ),
      home: PageNav(),
    );
  }
}