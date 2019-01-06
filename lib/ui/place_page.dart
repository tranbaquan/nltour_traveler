import 'package:flutter/material.dart';
import 'package:nltour_traveler/controller/place_controller.dart';
import 'package:nltour_traveler/model/place.dart';
import 'package:nltour_traveler/ui/widget/dialog.dart';
import 'package:nltour_traveler/ui/widget/menu_card.dart';
import 'package:nltour_traveler/ui/widget/nl_button.dart';
import 'package:nltour_traveler/ui/widget/nl_card.dart';

class PlacePage extends StatefulWidget {
  @override
  PlacePageState createState() {
    return new PlacePageState();
  }
}

class PlacePageState extends State<PlacePage> {
  Dialogs dialog = Dialogs();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      drawer: Drawer(
        child: MenuCard(),
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

  Future<List<Widget>> getAllPlaces() async {
    var res = List<Widget>();
    var placeController = PlaceController();
    List<Place> places = await placeController.getAll();
    for (Place place in places) {
      final card = Container(
        margin: EdgeInsets.only(bottom: 10),
        child: NLCardExpand(
          image: place.imageUrl,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                place.name,
                style: TextStyle(fontFamily: 'Normal'),
              ),
              Expanded(
                child: Text(
                  place.description,
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: 'Semilight',
                  ),
                  maxLines: 4,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                child: RaisedOutlineButton(
                  height: 25,
                  onPressed: () {
                    dialog.confirm(context, 'Detail', _showDetail(place));
                  },
                  child: Text(
                    'View',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
      res.add(card);
    }

    return res;
  }

  Widget _showDetail(Place place) {
    return null;
  }
}
