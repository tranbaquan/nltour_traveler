import 'package:flutter/material.dart';
import 'package:nltour_traveler/controller/place_controller.dart';
import 'package:nltour_traveler/controller/tour_controller.dart';
import 'package:nltour_traveler/controller/traveler_controller.dart';
import 'package:nltour_traveler/model/tour/place.dart';
import 'package:nltour_traveler/model/tour/tour.dart';
import 'package:nltour_traveler/model/traveler/traveler.dart';
import 'package:nltour_traveler/ui/widget/nl_app_bar.dart';
import 'package:nltour_traveler/ui/widget/nl_card.dart';
import 'package:nltour_traveler/ui/widget/nl_menu_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _HomePageState();
  }
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NLAppbar.buildAppbar(context, 'NLTour'),
      drawer: NLMenuCard(),
      body: buildContent(context),
    );
  }

  @override
  bool get wantKeepAlive => true;

  Widget buildContent(BuildContext context) {
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
                      color: Colors.grey[700],
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
              addAutomaticKeepAlives: true,
            );
          }
          return Center(child: CircularProgressIndicator());
        },
        future: getPlaceTour(),
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
      child: NLFormCard(),
    );
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          widget1,
          widget2,
          widget3,
          widget4,
        ],
      ),
    );
  }

  Future<Tour> bookATour(DateTime date, TimeOfDay time, Place place) async {
    var tour = Tour();
    DateTime m =
        DateTime(date.year, date.month, date.day, time.hour, time.minute);
    tour.startDate = m;
    tour.place = place;
    final prefs = await SharedPreferences.getInstance();
    String email = prefs.getString('email');
    var travelerController = TravellerController();
    Traveler traveler = await travelerController.findByEmail(email);
    tour.traveler = traveler;
    tour.tourGuide = null;
    tour.isAccepted = false;

    var tourController = TourController();
    Tour t = await tourController.createTour(tour);
    return t;
  }

  Future<List<Widget>> getPlaceTour() async {
    var res = List<Widget>();
    var placeController = PlaceController();
    List<Place> places = await placeController.getAll();
    for (Place place in places) {
      final card = NLPlaceCard(
        place: place,
        height: 200,
        width: 150,
      );
      res.add(card);
    }
    return res;
  }
}
