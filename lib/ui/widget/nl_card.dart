import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:datetime_picker_formfield/time_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:intl/intl.dart';
import 'package:nltour_traveler/controller/place_controller.dart';
import 'package:nltour_traveler/controller/tour_controller.dart';
import 'package:nltour_traveler/controller/traveler_controller.dart';
import 'package:nltour_traveler/model/collaborator.dart';
import 'package:nltour_traveler/model/place.dart';
import 'package:nltour_traveler/model/tour.dart';
import 'package:nltour_traveler/model/traveler.dart';
import 'package:nltour_traveler/model/type.dart';
import 'package:nltour_traveler/ui/widget/nl_button.dart';
import 'package:nltour_traveler/ui/widget/nl_dialog.dart';
import 'package:nltour_traveler/utils/dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NLPlaceCard extends StatelessWidget {
  final Place place;
  final double height;
  final double width;

  const NLPlaceCard({Key key, this.place, this.height, this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final widget = Card(
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey[500],
              offset: Offset(0.0, 1.5),
              blurRadius: 1.5,
            ),
          ],
        ),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              width: width,
              height: height,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child: Image.network(
                  place.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                color: Color(0xFF008fe5),
                borderRadius: BorderRadius.circular(5.0),
                gradient: LinearGradient(
                  colors: [Color(0xFF008fe5), Colors.transparent],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  verticalDirection: VerticalDirection.up,
                  children: <Widget>[
                    RaisedOutlineButton(
                      height: 25,
                      onPressed: () {
                        NLDialog.showCustomContentDialog(
                            context,
                            'Book tour',
                            NLCardForm(
                              place: place,
                            ));
                      },
                      child: Text(
                        'BOOK',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Text(
                      place.name,
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
    return widget;
  }
}

class NLHistory extends StatelessWidget {
  final Tour tour;

  const NLHistory({Key key, this.tour}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var dateFormat = DateFormat('MMM dd, yyyy');
    final widget = Container(
      height: 150,
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey[500],
            offset: Offset(0.0, 1.5),
            blurRadius: 1.5,
          ),
        ],
      ),
      child: GestureDetector(
        onTap: () {
          tour.tourGuide == null ? showPending(context) : print('abc');
        },
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey[500],
                    offset: Offset(1.5, 0),
                    blurRadius: 1.5,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  tour.place.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      tour.place.name,
                      style: TextStyle(fontFamily: 'Normal'),
                    ),
                    Text(
                      "Guide: " +
                          (tour.tourGuide == null
                              ? "Finding tour guide"
                              : tour.tourGuide.lastName +
                                  " " +
                                  tour.tourGuide.firstName),
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'Semilight',
                      ),
                    ),
                    Text(
                      "Price: " + tour.price.toString(),
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'Semilight',
                      ),
                    ),
                    Text(
                      "Date: " + dateFormat.format(tour.startDate),
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'Semilight',
                      ),
                    ),
                    Text(
                      "Status: " + getStatus(),
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'Semilight',
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        tour.tourGuide != null
                            ? RaisedOutlineButton(
                                height: 25,
                                onPressed: () {},
                                child: Text(
                                  'Contact Guide',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              )
                            : RaisedOutlineButton(
                                height: 25,
                                onPressed: () {},
                                child: Text(
                                  'Pay for tour',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
    return widget;
  }

  String getStatus() {
    if (tour.tourGuide == null) {
      return "Waiting";
    } else if (tour.startDate.isAfter(DateTime.now())) {
      return "Accepted";
    } else {
      return "Completed";
    }
  }

  void showPending(BuildContext context) {
    var content = Container(
      child: FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView(
              children: snapshot.data,
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
        future: getPendingGuild(),
      ),
    );
    NLDialog.showCustomContentDialog(context, 'Registering', content);
  }

  getPendingGuild() async {
    TourController controller = TourController();
    var res = List<Widget>();
    List<Collaborator> collaborators =
        await controller.getRegisteringTours(this.tour.id);
    for (Collaborator c in collaborators) {
      var row = Container(
        padding: EdgeInsets.only(left: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              "Tour guide: " + c.firstName + " " + c.lastName,
              style: TextStyle(fontSize: 12),
            ),
            Text(
              "Gender: " + (c.gender == Gender.MALE ? 'Male' : 'Female'),
              style: TextStyle(fontSize: 12),
            ),
            Text(
              "Type: " + getTourGiudeType(c.type),
              style: TextStyle(fontSize: 12),
            ),
            Text(
              "Languages: " + c.languages.primaryLanguage,
              style: TextStyle(fontSize: 12),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                SimpleRoundButton(
                  onPressed: () {
                    goToMessage(c.email);
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
                  child: SimpleRoundButton(
                    onPressed: () {
                      acceptGuide(c.email);
                    },
                    btnText: 'Get',
                    btnHeight: 30,
                    btnWidth: 80,
                    backgroundColor: Color(0xFF008fe5),
                    roundColor: Color(0xFF008fe5),
                    textColor: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
      var divider = Divider(
        color: Color(0xff383838),
        indent: 19.0,
      );
      res.add(row);
      res.add(divider);
    }
    return res;
  }

  String getTourGiudeType(TourGuideType type) {
    if (type == TourGuideType.FREELANCER) return 'Freelacer';
    if (type == TourGuideType.PROFESSOR) return 'Professor';
    if (type == TourGuideType.RESIDENT) return 'Resident';
    if (type == TourGuideType.STUDENT) return 'Student';
    return '';
  }

  void goToMessage(String email) {
    //TODO
  }

  void acceptGuide(String email) {

  }
}

class NLCardPlaceExpand extends StatelessWidget {
  final Place place;

  const NLCardPlaceExpand({Key key, this.place}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget widget = Container(
      height: 150,
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey[500],
            offset: Offset(0.0, 1.5),
            blurRadius: 1.5,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey[500],
                  offset: Offset(1.5, 0),
                  blurRadius: 1.5,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                place.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
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
                        Dialogs dialog = Dialogs();
                        dialog.confirm(context, place, _showDetail(place));
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
          )
        ],
      ),
    );
    return widget;
  }

  Widget _showDetail(Place place) {
    return Column(
      children: <Widget>[
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                place.description,
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'Semilight',
                ),
              ),
              Image.network(
                place.imageUrl,
                fit: BoxFit.cover,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class NLCardForm extends StatefulWidget {
  final Place place;

  const NLCardForm({Key key, this.place}) : super(key: key);

  @override
  _NLCardFormState createState() {
    return new _NLCardFormState(place);
  }
}

class _NLCardFormState extends State<NLCardForm> {
  DateFormat _dateFormat;
  DateFormat _timeFormat;
  DateTime _date;
  TimeOfDay _time;
  Place _place;
  TextEditingController _placeController;
  TextEditingController _descriptionController;
  List<Place> _data;

  _NLCardFormState(this._place) {
    _dateFormat = DateFormat('MMM dd, yyyy');
    _timeFormat = DateFormat('hh:mm a');
    _date = null;
    _time = null;
    _placeController = TextEditingController();
    _descriptionController = TextEditingController();
    _data = null;
    if (_place != null) {
      _placeController.text = _place.name;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        color: Colors.white,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              TypeAheadField(
                textFieldConfiguration: TextFieldConfiguration(
                  decoration: InputDecoration(
                    hintText: 'Enter destination',
                  ),
                  controller: _placeController,
                ),
                suggestionsCallback: (pattern) async {
                  var placeController = PlaceController();
                  _data = await placeController.findByName(pattern);
                  var suggestion = List<String>();
                  for (Place p in _data) {
                    suggestion.add(p.name);
                  }
                  return suggestion;
                },
                itemBuilder: (context, suggestion) {
                  return ListTile(
                    title: Text(suggestion),
                  );
                },
                transitionBuilder: (context, suggestionsBox, controller) {
                  return suggestionsBox;
                },
                onSuggestionSelected: (suggestion) {
                  _placeController.text = suggestion;
                  for (Place p in _data) {
                    if (p.name == suggestion) {
                      _place = p;
                    }
                  }
                },
              ),
              TimePickerFormField(
                format: _timeFormat,
                decoration: InputDecoration(
                  hintText: '9:00 AM',
                ),
                onChanged: (t) => setState(() => _time = t),
                editable: false,
              ),
              DateTimePickerFormField(
                format: _dateFormat,
                decoration: InputDecoration(
                  hintText: _dateFormat.format(DateTime.now()),
                ),
                dateOnly: true,
                editable: false,
                firstDate: DateTime.now(),
                onChanged: (dt) => setState(() => _date = dt),
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  hintText: 'Description',
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                child: RaisedGradientRoundedButton(
                  child: Text(
                    'BOOK',
                    style: TextStyle(color: Colors.white),
                  ),
                  height: 35,
                  onPressed: () {
                    NLDialog.showLoading(context);
                    bookATour().then((tour) {
                      if (tour != null) {
                        Navigator.of(context).pop();
                        NLDialog.showInfo(context, 'Book Successed!',
                            'Please waiting someone register tour!');
                      } else {
                        NLDialog.showInfo(context, 'Book Failed!',
                            'Sorry! Something wrong! please book again!');
                      }
                    });
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<Tour> bookATour() async {
    var tour = Tour();
    DateTime startDate =
        DateTime(_date.year, _date.month, _date.day, _time.hour, _time.minute);
    tour.startDate = startDate;
    tour.place = _place;
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
}
