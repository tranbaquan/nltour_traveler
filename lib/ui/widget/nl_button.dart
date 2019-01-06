import 'package:flutter/material.dart';

class RaisedGradientRoundedButton extends StatelessWidget {
  final Widget child;
  final double minWidth;
  final double height;
  final Function onPressed;

  const RaisedGradientRoundedButton({
    Key key,
    @required this.child,
    this.minWidth = 0,
    this.height = 40,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      minWidth: minWidth,
      child: Container(
        margin: EdgeInsets.only(bottom: 10.0),
        padding: EdgeInsets.all(0.0),
        height: height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF008fe5), Color(0xFF3eb43e)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey[500],
              offset: Offset(0.0, 1.5),
              blurRadius: 1.5,
            ),
          ],
          borderRadius: BorderRadius.circular(height),
        ),
        child: RaisedButton(
          onPressed: onPressed,
          padding: EdgeInsets.fromLTRB(30, 3, 30, 3),
          color: Colors.transparent,
          highlightElevation: 0.0,
          elevation: 0.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(height),
          ),
          child: child,
        ),
      ),
    );
  }
}

class RaisedOutlineRoundedButton extends StatelessWidget {
  final Widget child;
  final double minWidth;
  final double height;
  final Function onPressed;

  const RaisedOutlineRoundedButton(
      {Key key, this.minWidth, this.height, this.onPressed, this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      minWidth: minWidth,
      child: Container(
        margin: EdgeInsets.only(bottom: 10.0),
        padding: EdgeInsets.all(0.0),
        height: height,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey[500],
              offset: Offset(0.0, 1.5),
              blurRadius: 1.5,
            ),
          ],
          borderRadius: BorderRadius.circular(height),
        ),
        child: RaisedButton(
          onPressed: onPressed,
          child: child,
          color: Colors.white,
          elevation: 0.0,
          highlightElevation: 0.0,
          shape: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF008fe5), width: 1.0),
            borderRadius: BorderRadius.circular(height),
          ),
        ),
      ),
    );
  }
}

class RaisedOutlineButton extends StatelessWidget {
  final Widget child;
  final double minWidth;
  final double height;
  final Function onPressed;

  const RaisedOutlineButton(
      {Key key, this.minWidth = 0, this.height, this.onPressed, this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      minWidth: minWidth,
      child: Container(
        padding: EdgeInsets.all(0.0),
        height: height,
        decoration: BoxDecoration(
          color: Color(0xFF3eb43e),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: RaisedButton(
          onPressed: onPressed,
          color: Colors.transparent,
          highlightElevation: 0.0,
          elevation: 0.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
            side: BorderSide(
              color: Colors.white,
              width: 1.0,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}

class SimpleButton extends StatelessWidget {
  final String btnText;
  final Color textColor;
  final Function onPress;

  SimpleButton({
    this.btnText,
    this.textColor,
    this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: FlatButton(
        onPressed: onPress,
        child: Text(
          this.btnText,
          style: TextStyle(
            fontFamily: 'Semilight',
            fontSize: 12.0,
            color: this.textColor,
          ),
        ),
        color: Colors.white,
      ),
    );
  }
}

// simple round button
class SimpleRoundButton extends StatelessWidget {
  final Color backgroundColor;
  final Color roundColor;
  final String btnText;
  final Color textColor;
  final double btnHeight;
  final double btnWidth;
  final Function onPressed;

  SimpleRoundButton({
    this.backgroundColor,
    this.roundColor,
    this.btnText,
    this.textColor,
    this.btnHeight,
    this.btnWidth,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 0.0),
      height: this.btnHeight,
      width: this.btnWidth,
      decoration: BoxDecoration(
        color: this.backgroundColor,
        border: Border.all(
          color: this.roundColor,
        ),
        borderRadius: BorderRadius.circular(this.btnHeight / 2),
        boxShadow: [
          BoxShadow(
            color: Color(0x26000000),
            blurRadius: 7.0,
          ),
        ],
      ),
      child: FlatButton(
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              this.btnText,
              style: TextStyle(
                color: this.textColor,
                fontSize: 12.0,
                fontFamily: 'Semilight',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RadioItemButton extends StatelessWidget {
  final RadioModel _item;

  RadioItemButton(this._item);

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          new Container(
            margin: EdgeInsets.fromLTRB(0, 5, 20, 5),
            height: 30,
            width: 70.0,
            child: new Center(
              child: new Text(_item.buttonText,
                style: new TextStyle(
                    color:
                    _item.isSelected ? Colors.white : Color(0x80000000),
                    fontSize: 14.0,
                    fontWeight: FontWeight.w300),

              ),
            ),
            decoration: new BoxDecoration(
              color: _item.isSelected
                  ? Color(0xff008fe5)
                  : Colors.transparent,
              border: new Border.all(
                  width: 1.0,
                  color: _item.isSelected
                      ? Color(0xff008fe5)
                      : Colors.grey),
              borderRadius: const BorderRadius.all(const Radius.circular(4.0)),
            ),
          ),
        ],
      ),
    );
  }
}

class RadioModel {
  bool isSelected;
  final String buttonText;

  RadioModel(this.isSelected, this.buttonText);
}