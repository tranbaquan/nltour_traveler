import 'package:flutter/material.dart';
import 'package:nltour_traveler/model/tour/place.dart';
import 'package:nltour_traveler/ui/widget/nl_button.dart';

class Dialogs {
  _confirmResult(bool isYes, BuildContext context) {
    if (isYes) {
      Navigator.pop(context);
    } else {
      Navigator.pop(context);
    }
  }

  confirm(BuildContext context, Place place, Widget widget) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: ListTile(
            leading: Icon(
              Icons.location_on,
              color: Color(0xff008fe5),
            ),
            title: Text(
              place.name,
              style: TextStyle(
                color: Color(0xff008fe5),
                fontSize: 14.0,
                fontFamily: 'Normal',
              ),
            ),
            subtitle: Text(
              place.address.address,
              style: TextStyle(
                fontSize: 14.0,
                fontFamily: 'Light',
              ),
              maxLines: 1,
            ),
          ),
          content: SingleChildScrollView(
            child: widget,
          ),
          actions: <Widget>[
            NLSimpleButton(
              btnText: 'NO',
              textColor: Color(0xff008fe5),
              onPress: () => _confirmResult(false, context),
            ),
            NLSimpleRoundedButton(
              btnText: 'GET TOUR',
              btnWidth: 85.0,
              btnHeight: 35.0,
              roundColor: Color(0x00ffffff),
              textColor: Color(0xffffffff),
              backgroundColor: Color(0xff008fe5),
              onPressed: () => _confirmResult(true, context),
            ),
          ],
        );
      },
    );
  }

  confirm2(BuildContext context, String title, Widget widget, String txtNO,
      String txtAGREE) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: widget,
          ),
          actions: <Widget>[
            NLSimpleButton(
              btnText: txtNO,
              textColor: Color(0xff008fe5),
              onPress: () => _confirmResult(false, context),
            ),
            NLSimpleRoundedButton(
              btnText: txtAGREE,
              btnWidth: 85.0,
              btnHeight: 35.0,
              roundColor: Color(0x00ffffff),
              textColor: Color(0xffffffff),
              backgroundColor: Color(0xff008fe5),
              onPressed: () => _confirmResult(true, context),
            ),
          ],
        );
      },
    );
  }

  confirm3(BuildContext context, String title, Widget widget, String txtNO,
      Function onChange) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: widget,
          ),
          actions: <Widget>[
            NLSimpleButton(
              btnText: txtNO,
              textColor: Color(0xff008fe5),
              onPress: () => _confirmResult(false, context),
            ),
            NLSimpleRoundedButton(
              btnText: 'Change',
              btnWidth: 85.0,
              btnHeight: 35.0,
              roundColor: Color(0x00ffffff),
              textColor: Color(0xffffffff),
              backgroundColor: Color(0xff008fe5),
              onPressed: onChange,
            ),
          ],
        );
      },
    );
  }
}
