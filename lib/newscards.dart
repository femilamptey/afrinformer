
import 'package:afrinformer/newsscreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'light_color.dart';
import 'margin.dart';

class NewsCard extends StatelessWidget {

  final String title;
  final String snippet;
  final Image icon;
  final String articleLink;
  final String articleDate;
  final String source;

  NewsCard({Key key, this.title, this.snippet, this.icon, this.articleLink, this.source, this.articleDate});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    final Brightness brightnessValue = MediaQuery.of(context).platformBrightness;
    bool isDark = brightnessValue == Brightness.dark;

    DateTime date = DateTime.parse(articleDate);

    return Stack(
      children: <Widget>[
        Container(
          child: Column(
            children: <Widget>[
              Container(
                width: screenWidth(context),
                height: screenHeight(context) < 1000 ? screenHeight(context, percent: 0.58): screenHeight(context, percent: 0.38),
                margin: EdgeInsets.symmetric(horizontal:25),
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: isDark ? Colors.black45: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.18),
                        blurRadius: 20,
                        spreadRadius: 3.5,
                        offset: Offset(0, 13)),
                  ],
                ),
                child: FlatButton(
                  color: Colors.transparent,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Flexible(
                              child: Container(
                                margin: EdgeInsets.all(5),
                                alignment: Alignment.center,
                                //padding: EdgeInsets.symmetric(vertical: 5, horizontal: 17),
                                decoration: BoxDecoration(
                                    color: isDark ? CardColors.transparentBlack: CardColors.transparentWhite,
                                    borderRadius: BorderRadius.circular(5)),
                                child: Text(
                                  "$title",
                                  softWrap: true,
                                  style: GoogleFonts.cabin(
                                      textStyle: TextStyle(
                                          color: isDark ? Colors.white: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20
                                      )
                                  ),
                                ),
                              )
                          )
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal:10, vertical: 5),
                        child: icon,
                        alignment: Alignment.center,
                      ),
                      //SizedBox(height: 5),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal:10, vertical: 5),
                        child: Text(snippet, style: TextStyle(
                                color: isDark ? Colors.white: Colors.black,
                                fontSize: 12
                              ),
                        )
                      ),
                      //SizedBox(height: 5),
                      Padding(
                        padding: EdgeInsets.only(top: 10, right: 10, left: 10),
                        child: Text("Date Published: ${DateFormat.yMMMd().format(date)}", style: TextStyle(
                            color: isDark ? Colors.white: Colors.black,
                            fontSize: 10
                            ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        )
                      ),
                      Flexible(
                          child: Padding(
                              padding: EdgeInsets.only(top: 10, right: 10, left: 10, bottom: 10),
                              child: Text("Source: $source", style: TextStyle(
                                  color: isDark ? Colors.white: Colors.black,
                                  fontSize: 10
                                ),
                              )
                          )
                      )
                    ],
                  ),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => NewsScreen(url: articleLink)));
                  },
                )
              )
            ],
          ),
        ),
      ],
    );
  }


}