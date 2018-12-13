import 'package:flutter/material.dart';
import 'package:nltour_traveler/ui/home_page.dart';
import 'package:nltour_traveler/ui/widget/nltour_widget.dart';

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
      minWidth: MediaQuery.of(context).size.width,
      height: 40.0,
      child: RaisedButton(
        color: Colors.transparent,
        disabledColor: Colors.transparent,
        child: Text(
          'FORGOT PASSWORD',
          style: TextStyle(
              color: Color(0xFF008fe5),
              fontSize: 14.0,
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.normal),
        ),
      ),
    );

    final loginButton = Container(
      padding: EdgeInsets.all(0.0),
      margin: EdgeInsets.only(bottom: 5.0),
      child: RaisedGradientRoundedButton(
        child: Text(
          'SIGNIN',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        gradient: LinearGradient(
            colors: [Color(0xFF008fe5), Color(0xFF3eb43e)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomePage()));
        },
        height: 40.0,
      ),
    );

    final registerButton = ButtonTheme(
      minWidth: 250.0,
      height: 40.0,
      child: RaisedButton(
        color: Colors.white,
        disabledColor: Colors.white,
        shape: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF008fe5), width: 1.0),
          borderRadius: BorderRadius.circular(50.0),
        ),
        child: Text(
          'REGISTER',
          style: TextStyle(color: Color(0xFF3eb43e)),
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
            children: <Widget>[background, loginForm],
          ),
        ),
      ),
    );
  }
}
