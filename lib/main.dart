import 'package:flutter/material.dart';
import 'package:mycv/color.dart';
import 'package:mycv/landing.dart';
import 'configure/nonweb.dart' if (dart.library.html) 'configure/web.dart';

void main() {
  configureApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hi, I am Wahyudin',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: primarySwatchColor,
      ),
      initialRoute: 'index',
      home: LandingPage(),
      routes: {
        'index': (BuildContext context) => LandingPage(),
      },
    );
  }
}
