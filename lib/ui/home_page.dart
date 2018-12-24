import 'package:flutter/material.dart';
import 'package:nltour_traveler/ui/widget/nl_button.dart';
import 'package:nltour_traveler/ui/widget/nl_card.dart';

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
        padding: EdgeInsets.fromLTRB(
            MediaQuery.of(context).padding.left,
            MediaQuery.of(context).padding.top,
            MediaQuery.of(context).padding.right,
            MediaQuery.of(context).padding.top),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF008fe5), Color(0xFF3eb43e)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey[500],
              offset: Offset(0.0, 1.5),
              blurRadius: 1.5,
            ),
          ],
        ),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: Text(
            "NLTour",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          leading: IconButton(icon: Icon(Icons.menu), onPressed: () {}),
          centerTitle: true,
        ),
      ),
    );

    final widget1 = Container(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 16),
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              "Place of interest",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Lorem ipsum",
              ),
              Text(
                "see more",
              )
            ],
          )
        ],
      ),
    );
    final card = NLCard(
      image: 'assets/images/travel.jpg',
      cardName: 'Ben Thanh market',
      height: 200,
      width: 150,
      child: RaisedOutlineButton(
        height: 25,
        onPressed: () {},
        child: Text(
          'BOOK',
          style: TextStyle(
            color: Colors.white,
            fontSize: 12,
          ),
        ),
      ),
    );

    final widget2 = Container(
      height: 200,
      padding: EdgeInsets.only(left: 16),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[card, card, card, card],
      ),
    );

    final widget3 = Container(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 16),
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              "Create your own tour",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  "Lorem ipsum",
                ),
              ),
            ],
          )
        ],
      ),
    );

    final widget4 = Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: NLCardForm(),
    );
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            widget1,
            widget2,
            widget3,
            widget4,
          ],
        ),
      ),
    );
  }
}
