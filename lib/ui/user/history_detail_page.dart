import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nltour_traveler/controller/tour_controller.dart';
import 'package:nltour_traveler/controller/traveler_controller.dart';
import 'package:nltour_traveler/model/collaborator/collaborator.dart';
import 'package:nltour_traveler/model/collaborator/type.dart';
import 'package:nltour_traveler/model/tour/tour.dart';
import 'package:nltour_traveler/ui/payment_detail_page.dart';
import 'package:nltour_traveler/ui/user/mesage_page.dart';
import 'package:nltour_traveler/ui/widget/nl_app_bar.dart';
import 'package:nltour_traveler/ui/widget/nl_button.dart';
import 'package:nltour_traveler/utils/dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryDetailPage extends StatelessWidget {
  final Tour tour;

  const HistoryDetailPage({Key key, this.tour}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NLAppbar.buildAppbar(context, 'Tour Detail'),
      body: buildContent(context),
    );
  }

  buildContent(BuildContext context) {
    var dateFormat = DateFormat('MMMM dd, yyyy');
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: <Widget>[
            Stack(
              alignment: AlignmentDirectional(0, 1),
              children: <Widget>[
                Image.network(
                  tour.place.imageUrl,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),
                Container(
                  padding: EdgeInsets.all(16),
                  alignment: Alignment.centerLeft,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        tour.place.name,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              child: Card(
                child: Container(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Tour Detail',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Divider(
                        color: Colors.grey[900],
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: 80,
                              child: Text('Place:'),
                            ),
                            Expanded(
                              child: Text(
                                tour.place.name,
                                style: TextStyle(
                                  color: Colors.grey[700],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: 80,
                              child: Text('Date:'),
                            ),
                            Expanded(
                              child: Text(
                                dateFormat.format(tour.startDate),
                                style: TextStyle(
                                  color: Colors.grey[700],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: 80,
                              child: Text('Status:'),
                            ),
                            Expanded(
                              child: Text(
                                getStatusString(tour),
                                style: TextStyle(
                                  color: Colors.grey[700],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      tour.tourGuide != null
                          ? Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    width: 80,
                                    child: Text('Guide:'),
                                  ),
                                  Expanded(
                                    child: Text(
                                      tour.tourGuide.firstName +
                                          ' ' +
                                          tour.tourGuide.lastName,
                                      style: TextStyle(
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                      tour.tourGuide != null
                          ? Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    width: 80,
                                    child: Text('Price:'),
                                  ),
                                  Expanded(
                                    child: Text(
                                      '\$' + tour.price.toString(),
                                      style: TextStyle(
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                      getStatus(tour) == 1
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                !tour.paid
                                    ? NLSimpleRoundedButton(
                                        onPressed: () {
                                          goToPayment(context, tour);
                                        },
                                        btnWidth: 100,
                                        btnHeight: 30,
                                        backgroundColor: Color(0xFF3eb43e),
                                        roundColor: Color(0xFF3eb43e),
                                        textColor: Colors.white,
                                        btnText: 'Pay For Tour',
                                      )
                                    : Container(),
                                NLSimpleRoundedButton(
                                  onPressed: () {
                                    goToMessage(context, tour.tourGuide);
                                  },
                                  btnWidth: 100,
                                  btnHeight: 30,
                                  backgroundColor: Color(0xFF008fe5),
                                  roundColor: Color(0xFF008fe5),
                                  textColor: Colors.white,
                                  btnText: 'Message',
                                ),
                                NLSimpleRoundedButton(
                                  onPressed: () {
                                    cancelTour(context);
                                  },
                                  btnWidth: 100,
                                  btnHeight: 30,
                                  backgroundColor: Colors.white,
                                  roundColor: Color(0xFF008fe5),
                                  textColor: Color(0xFF008fe5),
                                  btnText: 'Cancel',
                                ),
                              ],
                            )
                          : Container(),
                      getStatus(tour) == 0
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                NLSimpleRoundedButton(
                                  onPressed: () {
                                    cancelTour(context);
                                  },
                                  btnWidth: 120,
                                  btnHeight: 30,
                                  backgroundColor: Colors.white,
                                  roundColor: Color(0xFF008fe5),
                                  textColor: Color(0xFF008fe5),
                                  btnText: 'Cancel Tour',
                                ),
                              ],
                            )
                          : Container(),
                      getStatus(tour) == 2
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                NLSimpleRoundedButton(
                                  onPressed: () {
                                    goToMessage(context, tour.tourGuide);
                                  },
                                  btnWidth: 120,
                                  btnHeight: 30,
                                  backgroundColor: Color(0xFF008fe5),
                                  roundColor: Color(0xFF008fe5),
                                  textColor: Colors.white,
                                  btnText: 'Message Guide',
                                ),
                              ],
                            )
                          : Container(),
                    ],
                  ),
                ),
              ),
            ),
            getStatus(tour) == 0
                ? Card(
                    child: Container(
                      padding: EdgeInsets.all(16),
                      child: FutureBuilder(
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: snapshot.data,
                            );
                          } else {
                            return Center(child: CircularProgressIndicator());
                          }
                        },
                        future: getPendingGuides(context),
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  int getStatus(Tour tour) {
    if (tour.tourGuide == null) {
      return 0;
    } else if (tour.startDate.isAfter(DateTime.now())) {
      return 1;
    } else {
      return 2;
    }
  }

  String getStatusString(Tour tour) {
    int stt = getStatus(tour);
    switch (stt) {
      case 0:
        return 'Finding tour guide';
      case 1:
        return 'Accepted';
      case 2:
        return 'Completed';
    }
    return '';
  }

  getPendingGuides(BuildContext context) async {
    TourController controller = TourController();
    var res = List<Widget>();
    res.add(Text(
      'Pending guides',
      style: TextStyle(
        fontWeight: FontWeight.bold,
      ),
    ));
    res.add(Divider(
      color: Colors.grey[900],
    ));
    List<Collaborator> collaborators =
        await controller.getRegisteringTours(this.tour.id);
    for (Collaborator c in collaborators) {
      var row = Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 80,
                    child: Text('Guide:'),
                  ),
                  Expanded(
                    child: Text(
                      c.firstName + " " + c.lastName,
                      style: TextStyle(
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 80,
                    child: Text('Gender:'),
                  ),
                  Expanded(
                    child: Text(
                      c.gender == Gender.MALE ? 'Male' : 'Female',
                      style: TextStyle(
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 80,
                    child: Text('Type:'),
                  ),
                  Expanded(
                    child: Text(
                      getTourGuideType(c.type),
                      style: TextStyle(
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 80,
                    child: Text('Price:'),
                  ),
                  Expanded(
                    child: Text(
                      getPrice(c.type),
                      style: TextStyle(
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 80,
                    child: Text('Languages:'),
                  ),
                  Expanded(
                    child: Text(
                      c.languages.primaryLanguage,
                      style: TextStyle(
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                NLSimpleRoundedButton(
                  onPressed: () {
                    goToMessage(context, c);
                  },
                  btnText: 'Message',
                  btnHeight: 30,
                  btnWidth: 80,
                  backgroundColor: Color(0xFF3eb43e),
                  roundColor: Color(0xFF3eb43e),
                  textColor: Colors.white,
                ),
                Container(
                  margin: EdgeInsets.only(left: 5),
                  child: NLSimpleRoundedButton(
                    onPressed: () {
                      acceptGuide(c.email);
                    },
                    btnText: 'View',
                    btnHeight: 30,
                    btnWidth: 80,
                    backgroundColor: Color(0xFF008fe5),
                    roundColor: Color(0xFF008fe5),
                    textColor: Colors.white,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 5),
                  child: NLSimpleRoundedButton(
                    onPressed: () {
                      acceptGuide(c.email);
                    },
                    btnText: 'Hire',
                    btnHeight: 30,
                    btnWidth: 80,
                    backgroundColor: Colors.white,
                    roundColor: Color(0xFF008fe5),
                    textColor: Color(0xFF008fe5),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
      var divider = Divider(
        color: Colors.grey[700],
      );
      res.add(row);
      res.add(divider);
    }
    return res;
  }

  String getTourGuideType(TourGuideType type) {
    if (type == TourGuideType.FREELANCER) return 'Freelacer';
    if (type == TourGuideType.PROFESSOR) return 'Professor';
    if (type == TourGuideType.RESIDENT) return 'Resident';
    if (type == TourGuideType.STUDENT) return 'Student';
    return '';
  }

  Future goToMessage(BuildContext context, Collaborator collaborator) async {
    final prefs = await SharedPreferences.getInstance();
    String myEmail = prefs.getString('email');
    TravellerController controller = TravellerController();
    controller.findByEmail(myEmail).then((data) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MessagePage(
                  traveler: data,
                  collaborator: collaborator,
                )),
      );
    });
  }

  void acceptGuide(String email) {}

  String getPrice(TourGuideType type) {
    switch (type) {
      case TourGuideType.FREELANCER:
        return '\$400.0';
      case TourGuideType.STUDENT:
        return '\$250.0';
      case TourGuideType.RESIDENT:
        return '\$300.0';
      case TourGuideType.PROFESSOR:
        return '\$500.0';
    }
    return '';
  }

  cancelTour(BuildContext context) async {
    NLDialog.showLoading(context);
    TourController controller = TourController();
    await controller.cancelTour(tour.id);
    Navigator.of(context).pop();
    Navigator.of(context).pop();
  }

  void goToPayment(BuildContext context, Tour tour) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaymentDetailPage(
              tour: tour,
            ),
      ),
    );
  }
}
