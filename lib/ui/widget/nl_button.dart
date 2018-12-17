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
