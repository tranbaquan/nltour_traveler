import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nltour_traveler/controller/traveler_controller.dart';
import 'package:nltour_traveler/model/traveler/traveler.dart';
import 'package:nltour_traveler/supporter/database/database.dart';
import 'package:nltour_traveler/supporter/validator/validator.dart';
import 'package:nltour_traveler/ui/widget/nl_button.dart';
import 'package:nltour_traveler/ui/widget/nl_form_field.dart';
import 'package:nltour_traveler/utils/dialog.dart';
import 'package:nltour_traveler/utils/session.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  void initState() {
    checkSession();
    super.initState();
  }

  checkSession() async {
    bool isLogged = await SessionChecker.isLogged();
    if (isLogged) {
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
              buildBackground(context),
              buildLoginForm(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget buildBackground(BuildContext context) {
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
            child: Image.asset('assets/images/travel.jpg',
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
              height: 240,
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(60),
            child: Image.network(
              'https://firebasestorage.googleapis.com/v0/b/nltour-2018.appspot.com/o/NLTravel.png?alt=media&token=a3a77bc0-3ebe-4f19-9dde-16a2bdf77a03',
              width: 120,
              height: 120,
              fit: BoxFit.cover,
            ),
          )
        ],
      ),
    );
  }

  Widget buildLoginForm(BuildContext context) {
    final usernameInput = TextInputFormField(
      hintText: 'USERNAME',
      validator: Validator.validateEmail,
      controller: _email,
      keyboardType: TextInputType.emailAddress,
    );

    final passwordInput = TextInputFormField(
      obscureText: true,
      hintText: 'PASSWORD',
      controller: _password,
      validator: Validator.validatePassword,
    );

    final forgotPasswordButton = ButtonTheme(
      minWidth: MediaQuery.of(context).size.width,
      height: 40.0,
      child: FlatButton(
        onPressed: () {
          Navigator.of(context).pushNamed("/forgot");
        },
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

    final loginButton = NLRaisedGradientRoundedButton(
      child: Text(
        'LOGIN',
        style: TextStyle(color: Colors.white),
      ),
      minWidth: MediaQuery.of(context).size.width,
      height: 40.0,
      onPressed: () {
        if (_formKey.currentState.validate()) {
          NLDialog.showLoading(context);
          _login();
        }
      },
    );

    final registerButton = NLRaisedOutlineRoundedButton(
      child: Text(
        'REGISTER',
        style: TextStyle(
          color: Color(0xFF3eb43e),
        ),
      ),
      height: 40,
      minWidth: double.infinity,
      onPressed: () {
        Navigator.of(context).pushNamed('/register');
      },
    );

    final loginForm = Container(
      padding: EdgeInsets.all(80.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            height: 60,
            margin: EdgeInsets.only(bottom: 10),
            child: usernameInput,
          ),
          Container(
            height: 60,
            margin: EdgeInsets.only(bottom: 10),
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
    var controller = TravellerController();
    controller.login(traveler).then((data) {
      Navigator.of(context).pop();
      if (data != null) {
        _saveUser(data);
        Navigator.of(context).pushReplacementNamed("/home");
      } else {
        NLDialog.showInfo(
            context, 'Login Failed', 'Email or password is incorrect!');
      }
    });
  }

  void _saveUser(Traveler data) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('logged', true);
    await DatabaseProvider.db.deleteAll();
    await DatabaseProvider.db.addTraveler(data);
  }
}
