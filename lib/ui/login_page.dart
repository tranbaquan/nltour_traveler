import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nltour_traveler/controller/login_page_controller.dart';
import 'package:nltour_traveler/model/traveler.dart';
import 'package:nltour_traveler/supporter/auth.dart';
import 'package:nltour_traveler/supporter/validator.dart';
import 'package:nltour_traveler/ui/widget/nl_button.dart';
import 'package:nltour_traveler/ui/widget/nl_form.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> implements AuthStateListener  {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _email = TextEditingController();
  final _password = TextEditingController();
  var authStateProvider = new AuthStateProvider();

  _LoginPageState() {
    authStateProvider.subscribe(this);
  }

//  @override
//  void didChangeDependencies() {
//    check();
//    super.didChangeDependencies();
//  }

  @override
  void initState(){
    check();
    super.initState();
  }

  Future check() async {
    final prefs = await SharedPreferences.getInstance();
    bool isLogged = prefs.get('logged');
    if(isLogged) {
      Navigator.of(context).pushReplacementNamed("/home");
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              buildBackGround(context),
              buildLoginForm(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget buildBackGround(BuildContext context) {
    return Container(
      child: Stack(
        alignment: AlignmentDirectional(0, 2),
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey[500],
                  offset: Offset(0.0, 1.5),
                  blurRadius: 1.5,
                ),
              ],
            ),
            child: Image.asset(
              'assets/images/travel.jpg',
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
              height: 240,
            ),
          ),
          Icon(
            Icons.brightness_1,
            size: 120,
            color: Colors.greenAccent,
          )
        ],
      ),
    );
  }

  Widget buildLoginForm(BuildContext context) {
    final usernameInput = TextInputForm(
      hintText: 'USERNAME',
      validator: Validator.validateEmail,
      controller: _email,
      keyboardType: TextInputType.emailAddress,
    );

    final passwordInput = TextInputForm(
      obscureText: true,
      hintText: 'PASSWORD',
      controller: _password,
      validator: Validator.validatePassword,
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
        _login();
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
            height: 60,
            margin: EdgeInsets.only(bottom: 10.0),
            child: usernameInput,
          ),
          Container(
            height: 60,
            margin: EdgeInsets.only(bottom: 10.0),
            child: passwordInput,
          ),
          Container(
            margin: EdgeInsets.only(bottom: 10.0),
            child: forgotPasswordButton,
          ),
          loginButton,
          registerButton
        ],
      ),
    );
    return Form(
      key: _formKey,
      child: loginForm,
      autovalidate: true,
    );
  }

  _login() async {
    final Traveler traveler =
        Traveler(email: _email.text, password: _password.text);
    print(json.encode(traveler));
    var controller = LoginPageController();
    final prefs = await SharedPreferences.getInstance();
    controller.login(traveler).then((data) {
      print(data);
      if (data != null) {
        prefs.setBool('logged', true);
        prefs.setString('email', data.email);
        authStateProvider.notify(AuthState.LOGGED_IN);
        print('ok');
      }
    });
  }

  @override
  void onAuthStateChanged(AuthState state) {
    if (state == AuthState.LOGGED_IN) {
      Navigator.of(context).pushReplacementNamed("/home");
    }
  }
}
