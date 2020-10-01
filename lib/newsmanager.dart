import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';


class NewsManager {

  NewsManager._();
  static final String _apiKey = "8BB34CFF340D41D19FE4AC8025B0C52D";
  static final LocalStorage storage = LocalStorage("countries");

  static Future<List<dynamic>> getNews() async {

    List<dynamic> data = [];
    String country = storage.getItem("country");

    await http.get("https://api.breakingapi.com/news?q=coronavirus+$country&type=headlines&locale=en-US&page_size=50&output=json&api_key=$_apiKey").then((value) {
      data = json.decode(value.body)["articles"];
    });

    return data;

  }

  static Future<dynamic> getArticle() async {



  }

}