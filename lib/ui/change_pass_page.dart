import 'package:device_id/device_id.dart';
import 'package:flutter/material.dart';
import 'package:nltour_traveler/controller/traveler_controller.dart';
import 'package:nltour_traveler/supporter/validator.dart';
import 'package:nltour_traveler/ui/widget/nl_button.dart';
import 'package:nltour_traveler/ui/widget/nl_form.dart';
import 'package:nltour_traveler/utils/dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangePassPage extends StatefulWidget {
  @override
  ChangePassPageState createState() {
    return new ChangePassPageState();
  }
}

class ChangePassPageState extends State<ChangePassPage> {
  final _pass = TextEditingController();
  final _rePass = TextEditingController();
  final GlobalKey<FormState> _changePassKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 80, horizontal: 30),
            child: Form(
              autovalidate: true,
              key: _changePassKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  TextInputForm(
                    validator: Validator.validatePassword,
                    textAlign: TextAlign.left,
                    controller: _pass,
                    obscureText: true,
                    hintText: "Enter your new password",
                  ),
                  TextInputForm(
                    validator: (value) {
                      if (value != _pass.text) {
                        return "Password is not match!";
                      }
                    },
                    obscureText: true,
                    textAlign: TextAlign.left,
                    controller: _rePass,
                    hintText: "Re-enter your new password",
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 16),
                    child: RaisedGradientRoundedButton(
                      child: Text(
                        "Change Password",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      height: 40,
                      minWidth: 250,
                      onPressed: () {
                        NLDialog.showLoading(context);
                        _changePass();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  PreferredSize buildAppBar(BuildContext context) {
    final appBar = PreferredSize(
      preferredSize: Size(double.infinity, 100.0),
      child: Container(
        padding: EdgeInsets.fromLTRB(
            MediaQuery.of(context).padding.left,
            MediaQuery.of(context).padding.top,
            MediaQuery.of(context).padding.right,
            MediaQuery.of(context).padding.top),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF008fe5), Color(0xFF3eb43e)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey[500],
              offset: Offset(0.0, 1.5),
              blurRadius: 1.5,
            ),
          ],
        ),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: Text(
            "NLTour",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
      ),
    );
    return appBar;
  }

  void _changePass() async {
    var controller = TravellerController();
    var deviceInfo = await DeviceId.getID;
    final prefs = await SharedPreferences.getInstance();
    String email = prefs.get('email');
    controller.changePassword(email, _pass.text, deviceInfo).then((data) {
      if (data == null) {
        Navigator.of(context).pop();
        NLDialog.showInfo(context, "Change Password Failed", "Please check your network");
      } else {
        prefs.setBool('logged', true);
        prefs.setString('avatar', data.avatar);
        prefs.setString('firstName', data.firstName);
        prefs.setString('lastName', data.lastName);
        Navigator.of(context).pushReplacementNamed('/home');
      }
    });
  }
}
