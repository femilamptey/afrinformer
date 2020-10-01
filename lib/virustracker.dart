import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:localstorage/localstorage.dart';

class VirusTracker {
  VirusTracker._();

  static LocalStorage storage = LocalStorage("countries");
  static String mostRecentDate = "${DateFormat.y().format(DateTime.now().add(Duration(days: 1)))}-${DateFormat.M().format(DateTime.now().add(Duration(days: 1)))}-${DateFormat.d().format(DateTime.now().add(Duration(days: 1)))}";
  static String dispMostRecentDate = "${DateFormat.y().format(DateTime.now())}/${DateFormat.M().format(DateTime.now())}/${DateFormat.d().format(DateTime.now())}";
  static String previousDate = "${DateFormat.y().format(DateTime.now().subtract(Duration(days: 2)))}-${DateFormat.M().format(DateTime.now().subtract(Duration(days: 2)))}-${DateFormat.d().format(DateTime.now().subtract(Duration(days: 2)))}";
  static String dispPreviousDate = "${DateFormat.y().format(DateTime.now().subtract(Duration(days: 1)))}/${DateFormat.M().format(DateTime.now().subtract(Duration(days: 1)))}/${DateFormat.d().format(DateTime.now().subtract(Duration(days: 1)))}";

  static Map<String, dynamic> afrcases = {};
  static int allAfrCases = 0;
  static int allAfrActiveCases = 0;
  static int allAfrDeaths = 0;
  static int allAfrRecoveries = 0;
  static int allAfrNewCases = 0;
  static int allAfrNewDeaths = 0;
  static int allAfrNewRecoveries = 0;
  static int previousAfrCases = 0;
  static int previousAfrDeaths = 0;
  static int previousAfrRecoveries = 0;
  static int selectedCountryCases = 0;
  static int selectedCountryActiveCases = 0;
  static int selectedCountryDeaths = 0;
  static int selectedCountryRecoveries = 0;
  static int selectedCountryNewCases = 0;
  static int selectedCountryNewDeaths = 0;
  static int selectedCountryNewRecoveries = 0;
  static int selectedCountryPreviousCases = 0;
  static int selectedCountryPreviousDeaths = 0;
  static int selectedCountryPreviousRecoveries = 0;

  static const Map<String, dynamic> countries = {
    "Algeria": "DZA",
    "Angola": "AGO",
    "Benin": "BEN",
    "Botswana": "BWA",
    "Burkina Faso": "BFA",
    "Burundi": "BDI",
    "Cabo Verde": "CPV",
    "Cameroon": "CMR",
    "Central African Republic": "CAF",
    "Chad": "TCD",
    "Comoros": "COM",
    "DRC": "COD",
    "Republic of the Congo": "COG",
    "Côte d'Ivoire": "CIV",
    "Djibouti": "DJI",
    "Egypt": "EGY",
    "Equitorial Guinea": "GNQ",
    "Eritrea": "ERI",
    "Eswatini": "SWZ",
    "Ethiopia": "ETH",
    "Gabon": "GAB",
    "Gambia": "GMB",
    "Ghana": "GHA",
    "Guinea": "GIN",
    "Guinea-Bissau": "GNB",
    "Kenya": "KEN",
    "Lesotho": "LSO",
    "Liberia": "LBR",
    "Libya": "LBY",
    "Madagascar": "MDG",
    "Malawi": "MWI",
    "Mali": "MLI",
    "Mauritania": "MRT",
    "Mauritius": "MUS",
    "Morocco": "MAR",
    "Mozambique": "MOZ",
    "Namibia": "NAM",
    "Niger": "NER",
    "Nigeria": "NGA",
    "Rwanda": "RWA",
    "São Tomé and Príncipe": "STP",
    "Senegal": "SEN",
    "Seychelles": "SYC",
    "Sierra Leone": "SLE",
    "Somalia": "SOM",
    "South Africa": "ZAF",
    "South Sudan": "SSD",
    "Sudan": "SDN",
    "Tanzania": "TZA",
    "Togo": "TGO",
    "Tunisia": "TUN",
    "Uganda": "UGA",
    "Zambia": "ZMB",
    "Zimbabwe": "ZWE"
  };

  static Future<String> checkDataAvalability() async {

    mostRecentDate = "${DateFormat.y().format(DateTime.now().add(Duration(days: 1)))}-${DateFormat.M().format(DateTime.now().add(Duration(days: 1)))}-${DateFormat.d().format(DateTime.now().add(Duration(days: 1)))}";
    previousDate = "${DateFormat.y().format(DateTime.now().subtract(Duration(days: 2)))}-${DateFormat.M().format(DateTime.now().subtract(Duration(days: 2)))}-${DateFormat.d().format(DateTime.now().subtract(Duration(days: 2)))}";

    await http.get("https://covidapi.info/api/v1/global/timeseries/$previousDate/$mostRecentDate").then((onValue) {
        var cases = json.decode(onValue.body)["result"] as Map<dynamic, dynamic>;
        List<dynamic> test = cases["AFG"];
        //print(test);
        if (test.length < 2) {
          mostRecentDate = "${DateFormat.y().format(DateTime.now())}-${DateFormat.M().format(DateTime.now())}-${DateFormat.d().format(DateTime.now())}";
          dispMostRecentDate = "${DateFormat.y().format(DateTime.now())}/${DateFormat.M().format(DateTime.now())}/${DateFormat.d().format(DateTime.now())}";
          previousDate = "${DateFormat.y().format(DateTime.now().subtract(Duration(days: 3)))}-${DateFormat.M().format(DateTime.now().subtract(Duration(days: 3)))}-${DateFormat.d().format(DateTime.now().subtract(Duration(days: 3)))}";
          dispPreviousDate = "${DateFormat.y().format(DateTime.now().subtract(Duration(days: 2)))}/${DateFormat.M().format(DateTime.now().subtract(Duration(days: 2)))}/${DateFormat.d().format(DateTime.now().subtract(Duration(days: 2)))}";
          return "Not updated";
        } else {
          mostRecentDate = "${DateFormat.y().format(DateTime.now().add(Duration(days: 1)))}-${DateFormat.M().format(DateTime.now().add(Duration(days: 1)))}-${DateFormat.d().format(DateTime.now().add(Duration(days: 1)))}";
          previousDate = "${DateFormat.y().format(DateTime.now().subtract(Duration(days: 2)))}-${DateFormat.M().format(DateTime.now().subtract(Duration(days: 2)))}-${DateFormat.d().format(DateTime.now().subtract(Duration(days: 2)))}";
          dispMostRecentDate = "${DateFormat.y().format(DateTime.now())}/${DateFormat.M().format(DateTime.now())}/${DateFormat.d().format(DateTime.now())}";
          dispPreviousDate = "${DateFormat.y().format(DateTime.now().subtract(Duration(days: 1)))}/${DateFormat.M().format(DateTime.now().subtract(Duration(days: 1)))}/${DateFormat.d().format(DateTime.now().subtract(Duration(days: 1)))}";
          return "Updated";
        }
      }
    );
  }

  static Future<List<int>> fetchCases() async {

    await checkDataAvalability();

    print(previousDate);
    print(mostRecentDate);
    afrcases = {};
    allAfrCases = 0;
    await http.get("https://covidapi.info/api/v1/global/timeseries/$previousDate/$mostRecentDate")
        .then((onValue) {
      var cases = json.decode(onValue.body)["result"] as Map<dynamic, dynamic>;
      print(cases);
      int sumCountries = 0;
      cases.forEach((k, v) {
        if (countries.containsValue(k)) {
          sumCountries += 1;
          afrcases.putIfAbsent(k, () => v);
          print(sumCountries);
          print(afrcases);
        }
      });
      //print(json.decode(response.body)["countryitems"][0]);
    });

    calcAllCases();
    calcPreviousCases();
    //calcAllActiveCases();
    //calcAllNewCases();
    calcAllDeaths();
    calcPreviousDeaths();
    //calcAllNewDeaths();
    calcAllRecoveries();
    calcPreviousRecoveries();
    calcSelectedCountryCases();
    //calcSelectedCountryActiveCases();
    //calcSelectedCountryNewCases();
    calcSelectedCountryPreviousCases();
    calcSelectedCountryDeaths();
    //calcSelectedCountryNewDeaths();
    calcSelectedCountryPreviousDeaths();
    calcSelectedCountryRecoveries();
    calcSelectedCountryPreviousRecoveries();

    return [allAfrCases, previousAfrCases, allAfrDeaths, previousAfrDeaths,
      allAfrRecoveries, previousAfrRecoveries, selectedCountryCases,
      selectedCountryPreviousCases, selectedCountryDeaths,
      selectedCountryPreviousDeaths, selectedCountryRecoveries,
      selectedCountryPreviousRecoveries
    ];

  }

  static calcAllCases() {
    allAfrCases = 0;
    afrcases.forEach((k, v) {
      allAfrCases += v[1]["confirmed"];
    });
    print("allafrcases");
    print(allAfrCases);
  }

  static calcAllActiveCases() {
    allAfrActiveCases = 0;
    afrcases.forEach((k, v) {
      //allAfrActiveCases += v["total_active_cases"];
    });
  }

  static calcAllNewCases() {
    allAfrNewCases= 0;
    afrcases.forEach((k, v) {
      allAfrNewCases += v["total_new_cases_today"];
    });
  }

  static calcAllDeaths() {
    allAfrDeaths = 0;
    afrcases.forEach((k, v) {
      allAfrDeaths += v[1]["deaths"];
    });
    print("allafrdeaths");
    print(allAfrDeaths);
  }

  static calcAllNewDeaths() {
    allAfrNewDeaths = 0;
    afrcases.forEach((k, v) {
      allAfrNewDeaths += v["total_new_deaths_today"];
    });
  }

  static calcAllRecoveries() {
    allAfrRecoveries = 0;
    afrcases.forEach((k, v) {
      allAfrRecoveries += v[1]["recovered"];
    });
    print("allafrrecoveries");
    print(allAfrRecoveries);
  }

  static calcPreviousCases() {
    previousAfrCases = 0;
    afrcases.forEach((k, v) {
      previousAfrCases += v[0]["confirmed"];
    });
    print("previousafrcases");
    print(previousAfrCases);
  }

  static calcPreviousDeaths() {
    previousAfrDeaths = 0;
    afrcases.forEach((k, v) {
      previousAfrDeaths += v[0]["deaths"];
    });
    print("previousafrdeaths");
    print(previousAfrDeaths);
  }

  static calcPreviousRecoveries() {
    previousAfrRecoveries = 0;
    afrcases.forEach((k, v) {
      previousAfrRecoveries += v[0]["recovered"];
    });
    print("previousafrrecoveries");
    print(previousAfrRecoveries);
  }

  static calcSelectedCountryCases() {
    selectedCountryCases = 0;
    String country = storage.getItem("country");
    final id = countries[country];
    afrcases.forEach((k, v) {
      if (k == id) {
        print(id);
        print("id ova hia");
        selectedCountryCases = v[1]["confirmed"];
      }
    });
    print("selectedcountrycases");
    print(selectedCountryCases);
  }

  static calcSelectedCountryActiveCases() {
    selectedCountryActiveCases = 0;
    String country = storage.getItem("country");
    final id = countries[country];
    afrcases.forEach((k, v) {
      if (v["ourid"] == id) {
        print(id);
        print("id ova hia");
        selectedCountryActiveCases = v["total_active_cases"];
      }
    });
  }

  static calcSelectedCountryNewCases() {
    selectedCountryNewCases = 0;
    String country = storage.getItem("country");
    final id = countries[country];
    afrcases.forEach((k, v) {
      if (v["ourid"] == id) {
        print(id);
        print("id ova hia");
        selectedCountryNewCases = v["total_new_cases_today"];
      }
    });
  }

  static calcSelectedCountryDeaths() {
    selectedCountryDeaths = 0;
    String country = storage.getItem("country");
    final id = countries[country];
    afrcases.forEach((k, v) {
      if (k == id) {
        selectedCountryDeaths = v[1]["deaths"];
      }
    });
    print("selectedcountrydeaths");
    print(selectedCountryDeaths);
  }

  static calcSelectedCountryNewDeaths() {
    selectedCountryNewDeaths = 0;
    String country = storage.getItem("country");
    final id = countries[country];
    afrcases.forEach((k, v) {
      if (v["ourid"] == id) {
        selectedCountryNewDeaths = v["total_new_deaths_today"];
      }
    });
  }

  static calcSelectedCountryRecoveries() {
    selectedCountryRecoveries = 0;
    String country = storage.getItem("country");
    final id = countries[country];
    afrcases.forEach((k, v) {
      if (k == id) {
        selectedCountryRecoveries = v[1]["recovered"];
      }
    });
    print("selectedcountryrecoveries");
    print(selectedCountryRecoveries);
  }

  static calcSelectedCountryPreviousCases() {
    selectedCountryPreviousCases = 0;
    String country = storage.getItem("country");
    final id = countries[country];
    afrcases.forEach((k, v) {
      if (k == id) {
        selectedCountryPreviousCases = v[0]["confirmed"];
      }
    });
    print("selectedcountrypreviouscases");
    print(selectedCountryPreviousRecoveries);
  }

  static calcSelectedCountryPreviousDeaths() {
    selectedCountryPreviousDeaths = 0;
    String country = storage.getItem("country");
    final id = countries[country];
    afrcases.forEach((k, v) {
      if (k == id) {
        print(id);
        print("id ova hia");
        selectedCountryPreviousDeaths = v[0]["deaths"];
      }
    });
    print("selectedcountrydeaths");
    print(selectedCountryDeaths);
  }

  static calcSelectedCountryPreviousRecoveries() {
    selectedCountryPreviousRecoveries = 0;
    String country = storage.getItem("country");
    final id = countries[country];
    afrcases.forEach((k, v) {
      if (k == id) {
        selectedCountryPreviousRecoveries = v[0]["recovered"];
      }
    });
    print("selectedcountrypreviousrecoveries");
    print(selectedCountryPreviousRecoveries);
  }

}