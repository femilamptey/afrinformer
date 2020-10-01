import 'dart:convert';

import 'package:afrinformer/margin.dart';
import 'package:afrinformer/newscards.dart';
import 'package:afrinformer/newsmanager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'loader.dart';

class UpdatesScreen extends StatefulWidget {

  @override
  _UpdatesScreenState createState() => _UpdatesScreenState();
  LocalStorage storage = new LocalStorage("country");
}

class _UpdatesScreenState extends State<StatefulWidget> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    print(screenHeight(context));

    final RefreshController _refreshController = RefreshController();
    final Brightness brightnessValue = MediaQuery.of(context).platformBrightness;
    bool isDark = brightnessValue == Brightness.dark;

    List<Widget> newsCards(dynamic news) {

      List<Widget> newsCards = [SizedBox(height: 28.0)];

      for (var item in news) {
        newsCards.add(
          NewsCard(title: item["title"], snippet: item["snippet"],
              icon: Image.network("${item["primary_image_link"]}", height: screenHeight(context, percent: 0.2)),
              articleLink: item["link"],
              source: item["source"]["name"],
              articleDate: item["date_published"],
          ),
        );
        newsCards.add(SizedBox(height: 28.0));
      }

      return newsCards;
    }

    Widget body(dynamic data) {

      return SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        onRefresh: () {
          setState(() {

          });
        },
        child: ListView(
          children: newsCards(data),
        ),
      );
    }

    return FutureBuilder(
      future: NewsManager.getNews(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          print(snapshot.hasError);
          print(snapshot.error);
          print(snapshot.data);
          print("data hia");
          return body(snapshot.data);
        } else {
          return Stack(
            children: [
              new Opacity(
                opacity: 1.0,
                child: ModalBarrier(
                    dismissible: false, color: isDark ? Colors.black: Colors.white),
              ),
              new Center(
                child: ColorLoader(),
              ),
            ],
          );
        }
      },
    );
  }

}