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

  PreferredSize buildAppBar(BuildContext context) {
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

  Future<List<Widget>> getAllTour() async {
    var res = List<Widget>();
    var tourController = TourController();
    List<Tour> tours = await tourController.getAll();
    for (Tour t in tours) {
      final card = NLCard(
        image: t.place.imageUrl,
        cardName: t.place.name,
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
  }

  @override
  Widget build(BuildContext context) {
    final widget1 = Container(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 16),
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 20),
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
                "Adventure is worthwhile",
              ),
              Container(
                height: 12,
                child: FlatButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/place');
                  },
                  padding: EdgeInsets.zero,
                  splashColor: Colors.transparent,
                  child: Text(
                    "see more >>",
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.normal,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );

    final widget2 = Container(
      height: 200,
      padding: EdgeInsets.only(left: 16),
      child: FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView(
              scrollDirection: Axis.horizontal,
              children: snapshot.data,
            );
          }
          return Center(child: CircularProgressIndicator());
        },
        future: getAllTour(),
      ),
    );

    final widget3 = Container(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 16),
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 15),
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
                  "Take only memories, leave only footprints",
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
