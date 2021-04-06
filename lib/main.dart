import 'package:flutter/material.dart';
import 'package:mycv/color.dart';
import 'package:mycv/landing.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Wahyudin',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: primarySwatchColor,
      ),
      initialRoute: 'home',
      home: LandingPage(),
      routes: {
        'home': (BuildContext context) => LandingPage(),
      },
    );
  }
}
