import 'package:flutter/material.dart';
import 'package:tojuwa/screens/homepage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'COVID-19 Tracker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blue[200],
        scaffoldBackgroundColor: Colors.blue[50]
      ),
      home: Home(),
    );
  }
}