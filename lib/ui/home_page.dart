import 'package:flutter/material.dart';
import 'package:nltour_traveler/controller/tour_controller.dart';
import 'package:nltour_traveler/model/tour.dart';
import 'package:nltour_traveler/ui/widget/menu_card.dart';
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

  PreferredSize buildAppBar(BuildContext context){
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
          centerTitle: true,

        ),
      ),
    );
    return appBar;
  }

  List<Widget> getAllTour(){
    var res = List<Widget>();
    var tourController = TourController();
    tourController.getAll().then((data) {
      for(dynamic t in data) {
        Tour tour = Tour.fromJson(t);
        final card = NLCard(
          image: 'assets/images/travel.jpg',
          cardName: tour.place.name,
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

        res.add(card);
      }

      return res;
    });



  }

  @override
  Widget build(BuildContext context) {

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
//    final widget2 = Container(
//      height: 200,
//      padding: EdgeInsets.only(left: 16),
//      child: ListView(
//        scrollDirection: Axis.horizontal,
//        children: getAllTour(),
//      ),
//    );

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
      appBar: buildAppBar(context),
      drawer: Drawer(
        child: MenuCard(),
      ),
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
