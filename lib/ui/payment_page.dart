import 'package:flutter/material.dart';
import 'package:nltour_traveler/controller/tour_controller.dart';
import 'package:nltour_traveler/model/tour/tour.dart';
import 'package:nltour_traveler/ui/widget/nl_app_bar.dart';
import 'package:nltour_traveler/ui/widget/nl_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PaymentPage extends StatefulWidget {
  @override
  PaymentPageState createState() {
    return new PaymentPageState();
  }
}

class PaymentPageState extends State<PaymentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NLAppbar.buildAppbar(context, 'History'),
      body: buildBody(context),
    );
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
      if (!tour.paid && tour.tourGuide != null) {
        final card = Container(
            margin: EdgeInsets.only(bottom: 10),
            child: NLHistoryCard(
              tour: tour,
            ));
        res.add(card);
      }
    }
    return res;
  }
}
