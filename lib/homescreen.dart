import 'package:afrinformer/newsmanager.dart';
import 'package:afrinformer/virustracker.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'global_card.dart';
import 'loader.dart';

class HomeScreen extends StatefulWidget {

  static final String tag = 'homescreen';
  LocalStorage storage = LocalStorage("countries");

  @override
  _HomeScreenState createState() => _HomeScreenState();

}

class _HomeScreenState extends State<HomeScreen> {

  loadData() async {
    return await VirusTracker.fetchCases();
  }

  @override
  Widget build(BuildContext context) {

    final RefreshController _refreshController = RefreshController();
    final Brightness brightnessValue = MediaQuery.of(context).platformBrightness;
    bool isDark = brightnessValue == Brightness.dark;

    Icon showGrowthIcon(int currentData, int previousData) {
      Icon icon;
      if(currentData > previousData) {
        icon = Icon(Icons.arrow_upward, color: Colors.red,);
      } else if (currentData < previousData) {
        icon = Icon(Icons.arrow_downward, color: Colors.green,);
      } else {
        icon = Icon(Icons.hourglass_empty);
      }
      return icon;
    }

    List<Widget> requestCards(String country, dynamic data) {
      List<Widget> requests = [
        SizedBox(height: 20.0),
        Padding(
          padding: EdgeInsets.all(6),
          child: Text("The developer stands strongly against misinformation."
              " All data is sourced from the dataset provided by Johns Hopkins "
              "University Center for Systems Science and Engineering.",
            style: TextStyle(fontSize: 12, color: isDark ? Colors.white: Colors.black),
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: EdgeInsets.all(6),
          child: Text("Data represents statistics between ${VirusTracker.dispPreviousDate} "
              "and ${VirusTracker.dispMostRecentDate}, and is updated daily.",
            style: TextStyle(fontSize: 12, color: isDark ? Colors.white: Colors.black),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 20.0),
        GlobalSituationCard(
          cardTitle: 'Total African Cases',
          caseTitle: 'Total',
          currentData: data[0],
          newData: (data[0] - data[1]) > 0 ? data[0] - data[1]: 0,
          percentChange: ((data[0] - data[1])/data[1])*100,
          icon: showGrowthIcon(data[0], data[1]),
          isDark: isDark,
          cardColor: Colors.amberAccent,
        ),
        SizedBox(height: 20.0),
        GlobalSituationCard(
          cardTitle: 'Total African Deaths',
          caseTitle: 'Deaths',
          currentData: data[2],
          newData: (data[2] - data[3]) > 0 ? data[2] - data[3]: 0,
          percentChange:  (data[2] != 0 && data[3] != 0) ? ((data[2]-data[3])/data[3]) *100: -1,
          icon: showGrowthIcon(data[2], data[3]),
          isDark: isDark,
          cardColor: Colors.redAccent,
        ),
        SizedBox(height: 20.0),
        GlobalSituationCard(
          cardTitle: 'Total African Recoveries',
          caseTitle: 'Total',
          currentData: data[4],
          newData: (data[4] - data[5]) > 0 ? data[4] - data[5]: 0,
          percentChange:  (data[4] != 0 && data[5] != 0) ? ((data[4]-data[5])/data[5]) *100: -1,
          icon: showGrowthIcon(data[4], data[5]),
          isDark: isDark,
          cardColor: Colors.greenAccent,
        ),
        SizedBox(height: 20.0),
        GlobalSituationCard(
          cardTitle: "Cases in $country",
          caseTitle: "Total",
          currentData: data[6],
          newData: (data[6] - data[7]) > 0 ? data[6] - data[7]: 0,
          percentChange:  (data[6] != 0 && data[7] != 0) ? ((data[6]-data[7])/data[7]) *100: -1,
          isDark: isDark,
          icon: showGrowthIcon(data[6], data[7]),
          cardColor: Colors.amber,
        ),
        SizedBox(height: 20.0),
        GlobalSituationCard(
          cardTitle: "Total Deaths in $country",
          caseTitle: "Deaths",
          currentData: data[8],
          newData: (data[8] - data[9]) > 0 ? data[8] - data[9]: 0,
          percentChange: (data[8] != 0 && data[9] != 0) ? ((data[8]-data[9])/data[9]) *100: -1,
          isDark: isDark,
          icon: showGrowthIcon(data[8], data[9]),
          cardColor: Colors.red,
        ),
        SizedBox(height: 20.0),
        GlobalSituationCard(
          cardTitle: "Total Recoveries in $country",
          caseTitle: "Total",
          currentData: data[10],
          newData: (data[10] - data[11]) > 0 ? data[10] - data[11]: 0,
          percentChange: (data[10] != 0 && data[11] != 0) ? ((data[10]-data[11])/data[11]) *100: -1,
          isDark: isDark,
          icon: showGrowthIcon(data[10], data[11]),
          cardColor: Colors.green,
        ),
        SizedBox(height: 6.0),
        Padding(
          padding: EdgeInsets.all(6),
          child: Text("The developer stands strongly against misinformation."
          " All data is sourced from the dataset provided by Johns Hopkins "
              "University Center for Systems Science and Engineering.",
          style: TextStyle(fontSize: 12, color: isDark ? Colors.white: Colors.black),
          textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: EdgeInsets.all(6),
          child: Text("Data represents statistics between ${VirusTracker.dispPreviousDate} "
              "and ${VirusTracker.dispMostRecentDate}, and is updated daily.",
            style: TextStyle(fontSize: 12, color: isDark ? Colors.white: Colors.black),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 38.0),
      ];

      return requests;
    }

    Widget body(dynamic data) {
      String country = widget.storage.getItem("country");

      return SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        onRefresh: () {
          setState(() {
            VirusTracker.fetchCases();
          });
        },
        child: ListView(
          children: requestCards(country, data),
        ),
      );
    }

    return FutureBuilder(
      future: VirusTracker.fetchCases(),
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