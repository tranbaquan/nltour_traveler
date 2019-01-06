import 'package:flutter/material.dart';
import 'package:nltour_traveler/controller/tour_controller.dart';
import 'package:nltour_traveler/model/tour.dart';
import 'package:nltour_traveler/ui/widget/nl_menu_card.dart';
import 'package:nltour_traveler/ui/widget/nl_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryPage extends StatefulWidget {
  @override
  HistoryPageState createState() {
    return new HistoryPageState();
  }
}

class HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      drawer: Drawer(
        child: MenuCard(),
      ),
      body: buildBody(context),
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

  Widget buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView(
              scrollDirection: Axis.vertical,
              children: snapshot.data,
            );
          }
          return Center(child: CircularProgressIndicator());
        },
        future: getMyTours(),
      ),
    );
  }

  Future<List<Widget>> getMyTours() async {
    var res = List<Widget>();
    var tourController = TourController();
    final prefs = await SharedPreferences.getInstance();
    String email = prefs.getString('email');
    List<Tour> tours = await tourController.getMyTour(email);
    for (Tour tour in tours) {
      final card = Container(
          margin: EdgeInsets.only(bottom: 10),
          child: NLHistory(
            tour: tour,
          ));
      res.add(card);
    }

    return res;
  }
}
