import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:datetime_picker_formfield/time_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:intl/intl.dart';
import 'package:nltour_traveler/controller/place_controller.dart';
import 'package:nltour_traveler/ui/widget/nl_button.dart';

class NLCard extends StatelessWidget {
  final String image;
  final String cardName;
  final Widget child;
  final double height;
  final double width;

  const NLCard(
      {Key key, this.image, this.cardName, this.child, this.height, this.width})
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
                  image,
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
                    child,
                    Text(
                      cardName,
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

class NLCardExpand extends StatelessWidget {
  final String image;
  final Widget child;

  const NLCardExpand(
      {Key key, this.image, this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: child,
            ),
          )
        ],
      ),
    );
    return widget;
  }
}

class NLCardForm extends StatefulWidget {
  @override
  _NLCardFormState createState() {
    return new _NLCardFormState();
  }
}

class _NLCardFormState extends State<NLCardForm> {
  final dateFormat = DateFormat('MMM dd, yyyy');
  final timeFormat = DateFormat('hh:mm a');
  DateTime date;
  TimeOfDay time;
  final _place = TextEditingController();
  final _description = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          children: <Widget>[
            TypeAheadField(
              textFieldConfiguration: TextFieldConfiguration(
                decoration: InputDecoration(
                  hintText: 'Enter destination',
                ),
                controller: _place,
              ),
              suggestionsCallback: (pattern) async {
                var placeController = PlaceController();
                return await placeController.findByName(pattern);
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
                _place.text = suggestion;
              },

            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: 120,
                  child: TimePickerFormField(
                    format: timeFormat,
                    decoration: InputDecoration(
                      hintText: '9:00 AM',
                    ),
                    onChanged: (t) => setState(() => time = t),
                    editable: false,
                  ),
                ),
                Container(
                  width: 150,
                  child: DateTimePickerFormField(
                    format: dateFormat,
                    decoration: InputDecoration(
                      hintText: dateFormat.format(DateTime.now()),
                    ),
                    dateOnly: true,
                    editable: false,
                    firstDate: DateTime.now(),
                    onChanged: (dt) => setState(() => date = dt),
                  ),
                ),
              ],
            ),
            TextFormField(
              controller: _description,
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
                onPressed: bookATour(),
              ),
            )
          ],
        ),
      ),
    );
  }

  bookATour() {
    var tour = Tour();

  }
}
