import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final background = Container(
      child: Stack(
        alignment: AlignmentDirectional(0.0, 2.0),
        children: <Widget>[
          Image.asset(
            'assets/images/travel.jpg',
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.fitWidth,
          ),
          Icon(
            Icons.brightness_1,
            size: 120.0,
            color: Colors.greenAccent,
          )
        ],
      ),
    );

    final usernameInput = TextFormField(
      decoration: InputDecoration(
        hintText: 'USERNAME',
        hintStyle: TextStyle(
          color: Color(0xFF008fe5),
          fontSize: 14.0,
        ),
        border: UnderlineInputBorder(
            borderSide: BorderSide(
                color: Colors.white30, width: 1.0, style: BorderStyle.solid)),
      ),
      textAlign: TextAlign.center,
    );

    final passwordInput = TextFormField(
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'PASSWORD',
        hintStyle: TextStyle(
          color: Color(0xFF008fe5),
          fontSize: 14.0,
        ),
        border: UnderlineInputBorder(
            borderSide: BorderSide(
                color: Colors.white30, width: 1.0, style: BorderStyle.solid)),
      ),
      textAlign: TextAlign.center,
    );

    final forgotPasswordButton = ButtonTheme(
      minWidth: 250.0,
      height: 40.0,
      child: RaisedButton(
        color: Colors.transparent,
        disabledColor: Colors.transparent,
        child: Text(
          'FORGOT PASSWORD',
          style: TextStyle(
              color: Color(0xFF008fe5),
              fontSize: 14.0,
              fontStyle: FontStyle.normal),
        ),
      ),
    );

    final loginButton = ButtonTheme(
      minWidth: 250.0,
      height: 40.0,
      child: RaisedButton(
        padding: EdgeInsets.fromLTRB(50.0, 3.0, 50.0, 3.0),
        color: Colors.cyan,
        disabledColor: Colors.cyan,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.0),
            side: BorderSide(color: Colors.cyan, width: 1.0)),
        child: Text(
          'LOGIN',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );

    final registerButton = ButtonTheme(
      minWidth: 250.0,
      height: 40.0,
      child: RaisedButton(
        color: Colors.white,
        disabledColor: Colors.white,
        shape: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.cyan, width: 1.0),
          borderRadius: BorderRadius.circular(50.0),
        ),
        child: Text(
          'REGISTER',
          style: TextStyle(color: Colors.greenAccent),
        ),
      ),
    );

    final loginForm = Container(
      padding: EdgeInsets.all(80.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 16.0),
            child: usernameInput,
          ),
          Container(
            margin: EdgeInsets.only(bottom: 16.0),
            child: passwordInput,
          ),
          Container(
            margin: EdgeInsets.only(bottom: 16.0),
            child: forgotPasswordButton,
          ),
          loginButton,
          registerButton
        ],
      ),
    );

    return Scaffold(
      body: Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              background,
              loginForm
            ],
          ),
        ),
      ),
    );
  }
}
