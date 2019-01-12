import 'package:flutter/material.dart';
import 'package:nltour_traveler/controller/place_controller.dart';
import 'package:nltour_traveler/model/tour/place.dart';
import 'package:nltour_traveler/ui/widget/nl_app_bar.dart';
import 'package:nltour_traveler/ui/widget/nl_card.dart';
import 'package:nltour_traveler/ui/widget/nl_menu_card.dart';

class PlacePage extends StatefulWidget {
  @override
  PlacePageState createState() {
    return new PlacePageState();
  }
}

class PlacePageState extends State<PlacePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NLAppbar.buildAppbar(context, 'Place'),
      drawer: Drawer(
        child: NLMenuCard(),
      ),
      body: FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
              padding: EdgeInsets.all(16),
              child: ListView(
                children: snapshot.data,
              ),
            );
          } else {
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
        future: getAllPlaces(),
      ),
    );
  }

  Future<List<Widget>> getAllPlaces() async {
    var res = List<Widget>();
    var placeController = PlaceController();
    List<Place> places = await placeController.getAll();
    for (Place place in places) {
      final card = Container(
        margin: EdgeInsets.only(bottom: 10),
        child: NLPlaceBigCard(
          place: place,
        ),
      );
      res.add(card);
    }

    return res;
  }


}
