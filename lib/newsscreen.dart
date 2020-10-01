import 'package:afrinformer/loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class NewsScreen extends StatefulWidget{

  final String url;

  const NewsScreen({Key key, this.url}) : super(key: key);

  @override
  _NewsScreenState createState() => _NewsScreenState();

}

class _NewsScreenState extends State<NewsScreen> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    final Brightness brightnessValue = MediaQuery.of(context).platformBrightness;
    bool isDark = brightnessValue == Brightness.dark;


    final appBar = AppBar(
      title: Text("Article", style: TextStyle(color: isDark ? Colors.white: Colors.red, fontSize: 26.0)),
      backgroundColor: isDark ? Colors.black: Colors.white,
      leading: IconButton(icon:Icon(Icons.arrow_back),
        onPressed:() => Navigator.pop(context),
      ),
      iconTheme: IconThemeData(color: Colors.white, size: 26.0),

    );

    final body = WebviewScaffold(
      url: widget.url,
      appBar: appBar,
      initialChild: Container(
        child:  Center(
          child: ColorLoader(),
        ),
      ),
    );

    return body;

    return null;
  }

}