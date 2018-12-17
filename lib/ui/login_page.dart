import 'package:flutter/material.dart';
import 'package:nltour_traveler/ui/home_page.dart';
import 'package:nltour_traveler/ui/widget/nl_button.dart';
import 'package:nltour_traveler/ui/widget/nl_form.dart';

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

    final usernameInput = TextInputForm(
      hintText: 'USERNAME',
    );

    final passwordInput = TextInputForm(
      obscureText: true,
      hintText: 'PASSWORD',
    );

    final forgotPasswordButton = ButtonTheme(
      minWidth: MediaQuery.of(context).size.width,
      height: 40.0,
      child: FlatButton(
        onPressed: () {},
        child: Text(
          'FORGOT PASSWORD',
          style: TextStyle(
            color: Color(0xFF008fe5),
          ),
        ),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
    );

    final loginButton = RaisedGradientRoundedButton(
      child: Text(
        'LOGIN',
        style: TextStyle(color: Colors.white),
      ),
      minWidth: MediaQuery.of(context).size.width,
      height: 40.0,
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      },
    );

    final registerButton = RaisedOutlineRoundedButton(
      child: Text(
        'REGISTER',
        style: TextStyle(
          color: Color(0xFF3eb43e),
        ),
      ),
      height: 40.0,
      minWidth: MediaQuery.of(context).size.width,
      onPressed: () {},
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
