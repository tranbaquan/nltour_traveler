import 'package:device_id/device_id.dart';
import 'package:flutter/material.dart';
import 'package:nltour_traveler/controller/traveler_controller.dart';
import 'package:nltour_traveler/supporter/validator/validator.dart';
import 'package:nltour_traveler/ui/widget/nl_app_bar.dart';
import 'package:nltour_traveler/ui/widget/nl_button.dart';
import 'package:nltour_traveler/ui/widget/nl_form_field.dart';
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
      appBar: NLAppbar.buildAppbar(context, 'NLTour Support'),
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
                  TextInputFormField(
                    validator: Validator.validatePassword,
                    textAlign: TextAlign.left,
                    controller: _pass,
                    obscureText: true,
                    hintText: "Enter your new password",
                  ),
                  TextInputFormField(
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
                    child: NLRaisedGradientRoundedButton(
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

  void _changePass() async {
    var controller = TravellerController();
    var deviceInfo = await DeviceId.getID;
    final prefs = await SharedPreferences.getInstance();
    String email = prefs.get('email');
    controller.changePasswordByOtp(email, _pass.text, deviceInfo).then((data) {
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
