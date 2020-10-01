import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

import 'loader.dart';

class HealthGuidelinesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    final Brightness brightnessValue = MediaQuery.of(context).platformBrightness;
    bool isDark = brightnessValue == Brightness.dark;

    final appBar = AppBar(
      title: Text("Health Guidelines", style: TextStyle(color: isDark ? Colors.white: Colors.red, fontSize: 26.0)),
      backgroundColor: isDark ? Colors.black: Colors.white,
      leading: IconButton(icon:Icon(Icons.arrow_back),
        onPressed:() => Navigator.pop(context),
      ),
      iconTheme: IconThemeData(color: Colors.white, size: 26.0),

    );

    List<Widget> healthCards() {
      List<Widget> healthCards = [];

      healthCards.add(
        Card(
          child: FlatButton(
            child: ListTile(
              title: Text("World Health Organisation: FAQ", style: TextStyle(fontSize: 18),),
            ),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return WebviewScaffold(
                  url: "https://www.who.int/news-room/q-a-detail/q-a-coronaviruses",
                  appBar: appBar,
                  initialChild: Container(
                    child:  Center(
                      child: ColorLoader(),
                    ),
                  ),
                );
              }));
            },
          ),
        )
      );

      healthCards.add(
          Card(
            child: FlatButton(
              child: ListTile(
                title: Text("World Health Organisation: Advice", style: TextStyle(fontSize: 18),),
              ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                  return WebviewScaffold(
                    url: "https://www.who.int/teams/risk-communication/Individuals-and-communities",
                    appBar: appBar,
                    initialChild: Container(
                      child:  Center(
                        child: ColorLoader(),
                      ),
                    ),
                  );
                }));
              },
            ),
          )
      );

      healthCards.add(
          Card(
            child: FlatButton(
              child: ListTile(
                title: Text("Myth Busting", style: TextStyle(fontSize: 18),),
              ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                  return WebviewScaffold(
                    url: "https://www.who.int/emergencies/diseases/novel-coronavirus-2019/advice-for-public/myth-busters",
                    appBar: appBar,
                    initialChild: Container(
                      child:  Center(
                        child: ColorLoader(),
                      ),
                    ),
                  );
                }));
              },
            ),
          )
      );

      healthCards.add(
        Padding(
          padding: EdgeInsets.all(6),
          child: Text("At such a time like this, misinformation is lethal. "
              "Feel free to take screenshots from the certified sources of information "
              "provided by this app and share with your family and friends. "
              "Beware of chain messages from "
              "social media platforms and always verify any news you hear.",
            style: TextStyle(fontSize: 12, color: isDark ? Colors.white: Colors.black),
            textAlign: TextAlign.center,
          ),
        ),
      );

      return healthCards;

    }

    return Column(
      children: healthCards(),
    );
  }

}