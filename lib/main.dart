import 'package:flutter/material.dart';
import 'package:nltour_traveler/ui/login_page.dart';

void main() => runApp(NLTour());

class NLTour extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NLTour',
      theme: ThemeData(
        textSelectionColor: Colors.greenAccent,
        cursorColor: Colors.greenAccent,
        primaryColor: Colors.greenAccent,
      ),
      home: LoginPage(),
    );
  }
}
