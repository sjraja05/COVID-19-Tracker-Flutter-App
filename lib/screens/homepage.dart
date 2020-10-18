import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tojuwa/screens/helpline_screen.dart';
import 'package:tojuwa/screens/news_screen.dart';
import 'package:tojuwa/screens/statistics.dart';
import 'package:tojuwa/utils/constants.dart';
import 'package:tojuwa/widgets/dev_scaffold.dart';
import 'package:tojuwa/widgets/info_box.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tojuwa/screens/precautions.dart';
//import 'package:tojuwa/network/coviddata.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int totalCases = 0;
  int deaths = 0;
  int recovered = 0;
  int slCases = 0;
  int sldeaths = 0;
  int slrecovered = 0;
  int numberOfCountries = 0;
  List countries = [];

  Future getTotalCasesForCorona() async {
    String url = "https://covid19.mathdro.id/api";
    http.Response response = await http.get(url);
    if (response.statusCode >= 200 && response.statusCode <= 299) {
      Map<String, dynamic> data = jsonDecode(response.body);
      setState(() {
        totalCases = data['confirmed']['value'];
        deaths = data['deaths']['value'];
        recovered = data['recovered']['value'];
      });
      print(data);
    } else {
      print(response.statusCode);
    }
  }

  Future getCasesForCorona() async {
    String url = "https://covid19.mathdro.id/api/countries/Sri%20Lanka";
    http.Response response = await http.get(url);
    if (response.statusCode >= 200 && response.statusCode <= 299) {
      Map<String, dynamic> data = jsonDecode(response.body);
      setState(() {
        slCases = data['confirmed']['value'];
        sldeaths = data['deaths']['value'];
        slrecovered = data['recovered']['value'];
      });
      print(data);
    } else {
      print(response.statusCode);
    }
  }

  Future getCountriesData() async {
    String url = "https://covid19.mathdro.id/api/countries";
    http.Response response = await http.get(url);
    if (response.statusCode >= 200 && response.statusCode <= 299) {
      Map<String, dynamic> data = jsonDecode(response.body);
      setState(() {
        countries = data['countries'];
      });
      print(data);
    } else {
      print(response.statusCode);
    }
  }


  @override
  void initState() {
    getTotalCasesForCorona();
    getCasesForCorona();
    getCountriesData();
    Timer.periodic(
      Duration(hours: 1),
      (Timer t) => getTotalCasesForCorona(),
    );
    Timer.periodic(
      Duration(hours: 1),
      (Timer t) => getCasesForCorona(),
    );
    Timer.periodic(
      Duration(hours: 1),
      (Timer t) => getCountriesData(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DevScaffold(
      title: 'COVID-19 Tracker',
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Flexible(
                child: ListView(
                  children: <Widget>[
                    Text(
                      'Global', textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 15),
                    Row(
                      children: <Widget>[
                        InfoBox(
                          title: 'Total cases',
                          number: totalCases,
//                          number: 12345,
                          color: Colors.blue,
                          icon: Icon(FontAwesomeIcons.globeAmericas,
                              color: Colors.white, size: 20),
                        ),
                        SizedBox(width: 15),
                        InfoBox(
                          title: 'Countries',
                          color: Colors.orange,
                          icon: Icon(Icons.flag, color: Colors.white),
                          number: countries.length,
                          onPressed: () {},
                        ),
                      ],
                    ),
                    SizedBox(height: 25),
                    Row(
                      children: <Widget>[
                        InfoBox(
                          title: 'Deaths',
                          color: Colors.red,
                          icon: Icon(FontAwesomeIcons.skull,
                              color: Colors.white, size: 20),
                          number: deaths,
//                        number: 123,
                        ),
                        SizedBox(width: 15),
                        InfoBox(
                          title: 'Recovered',
                          number: recovered,
//                          number: 1234,
                          color: Colors.green,
                          icon: Icon(Icons.check, color: Colors.white),
                        ),
                      ],
                    ),
                    SizedBox(height: 25),
                    Text(
                      'Sri Lanka', textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 25),
                    Row(
                      children: <Widget>[
                        InfoBox(
                          title: 'Total cases',
                          number: slCases,
//                        number: 123,
                          color: Colors.blue,
                          icon: Icon(FontAwesomeIcons.home,
                              color: Colors.white, size: 20),
                        ),
                        SizedBox(width: 15),
                        InfoBox(
                          title: 'Deaths',
                          color: Colors.red,
                          icon: Icon(FontAwesomeIcons.skull,
                              color: Colors.white, size: 20),
                          number: sldeaths,
//                        number: 1,
                        ),
                      ],
                    ),
                    SizedBox(height: 25),
                    Row(
                      children: <Widget>[
                        InfoBox(
                          title: 'Recovered', 
                          number: slrecovered,
//                        number: 12,
                          color: Colors.green,
                          icon: Icon(Icons.check, color: Colors.white),
                        ),
                      ],
                    ),
                    SizedBox(height: 25),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                        color: kBoxLightColor,
                        borderRadius: kBoxesRadius,
                      ),
                      child: ListTile(
                        leading: Icon(
                          FontAwesomeIcons.readme,
                          color: Colors.blue,
                        ),
                        title: Text(
                          'Protective measures',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          'Protective measures against the coronavirus',
                          style: TextStyle(fontSize: 15),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Measures()),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 15),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                        color: kBoxLightColor,
                        borderRadius: kBoxesRadius,
                      ),
                      child: ListTile(
                        leading: Icon(
                          FontAwesomeIcons.readme,
                          color: Colors.blue,
                        ),
                        title: Text(
                          'Latest News',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          'Live updates about covid-19',
                          style: TextStyle(fontSize: 15),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CoronaNews()),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 15),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                        color: kBoxLightColor,
                        borderRadius: kBoxesRadius,
                      ),
                      child: ListTile(
                        leading: Icon(
                          FontAwesomeIcons.chartLine,
                          color: Colors.blue,
                        ),
                        title: Text(
                          'Statistics',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          'View the stats and trends of the infection',
                          style: TextStyle(fontSize: 15),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Statistics()),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 15),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                        color: kBoxLightColor,
                        borderRadius: kBoxesRadius,
                      ),
                      child: ListTile(
                        leading: Icon(
                          FontAwesomeIcons.phoneAlt,
                          color: Colors.blue,
                        ),
                        title: Text(
                          'Helpline',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          'Know anyone exhibiting symptoms and need help?',
                          style: TextStyle(fontSize: 15),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => HelpLine()),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}