import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _HomePageState(title: 'NLTour');
  }
}

class _HomePageState extends State<HomePage> {
  final String title;

  _HomePageState({this.title});

  @override
  Widget build(BuildContext context) {
    final appBar = PreferredSize(
      preferredSize: Size(double.infinity, 100.0),
      child: Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 17.0),
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF008fe5), Color(0xFF3eb43e)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey[500],
                offset: Offset(0.0, 1.5),
                blurRadius: 1.5,
              )
            ]),
        child: Text(title),
      ),
    );
    return Scaffold(
      appBar: appBar,
      body: Text("abc"),
    );
  }
}
