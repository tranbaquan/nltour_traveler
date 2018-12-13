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
        textSelectionColor: Color(0xFF008fe5),
        cursorColor: Color(0xFF008fe5),
        primaryColor: Color(0xFF008fe5),
        primaryColorDark: Colors.green
      ),
      home: LoginPage(),
    );
  }
}
