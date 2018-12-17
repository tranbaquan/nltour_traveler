import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:datetime_picker_formfield/time_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:nltour_traveler/ui/widget/nl_button.dart';
import 'package:nltour_traveler/ui/widget/nl_form.dart';

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
                child: Image.asset(
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

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Enter destination',
              ),
            ),
            TimePickerFormField(
              format: timeFormat,
              decoration: InputDecoration(
                hintText: '9:00 AM',
              ),
              initialValue: TimeOfDay(hour: 9, minute: 00),
              onChanged: (t) => setState(() => time = t),
            ),
            DateTimePickerFormField(
              format: dateFormat,
              decoration: InputDecoration(
                hintText: dateFormat.format(DateTime.now()),
              ),
              initialValue: DateTime.now(),
              dateOnly: true,
              onChanged: (dt) => setState(() => date = dt),
            ),
            TextFormField(
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
                onPressed: () {},
              ),
            )
          ],
        ),
      ),
    );
  }
}
