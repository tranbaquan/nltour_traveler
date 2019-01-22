import 'package:device_id/device_id.dart';
import 'package:flutter/material.dart';
import 'package:nltour_traveler/controller/otp_controller.dart';
import 'package:nltour_traveler/controller/traveler_controller.dart';
import 'package:nltour_traveler/model/common/otp.dart';
import 'package:nltour_traveler/supporter/validator/validator.dart';
import 'package:nltour_traveler/ui/widget/nl_app_bar.dart';
import 'package:nltour_traveler/ui/widget/nl_button.dart';
import 'package:nltour_traveler/ui/widget/nl_form_field.dart';
import 'package:nltour_traveler/utils/dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ForgotPage extends StatefulWidget {
  @override
  ForgotPageState createState() {
    return new ForgotPageState();
  }
}

class ForgotPageState extends State<ForgotPage> {
  final _email = TextEditingController();
  final _otpController = TextEditingController();
  final GlobalKey<FormState> _getOTPKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _validateOTPKey = GlobalKey<FormState>();
  bool isGotOTP = false;
  OTP _otp;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NLAppbar.buildAppbar(context, 'NLTour Support'),
      body: Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: buildBody(context),
        ),
      ),
    );
  }

  Widget buildBody(BuildContext context) {
    return !isGotOTP
        ? Container(
            padding: EdgeInsets.symmetric(vertical: 80, horizontal: 30),
            child: Form(
              autovalidate: true,
              key: _getOTPKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Container(
                    height: 60,
                    child: TextInputFormField(
                      validator: Validator.validateEmail,
                      textAlign: TextAlign.left,
                      controller: _email,
                      hintText: "Enter your email",
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 16),
                    child: NLRaisedGradientRoundedButton(
                      child: Text("SEND", style: TextStyle(
                        color: Colors.white,
                        fontSize: 16
                      ),),
                      height: 40,
                      minWidth: 250,
                      onPressed: () {
                        NLDialog.showLoading(context);
                        _getOTP();
                      },
                    ),
                  ),
                ],
              ),
            ),
          )
        : Container(
            padding: EdgeInsets.symmetric(vertical: 80, horizontal: 30),
            child: Form(
              autovalidate: true,
              key: _validateOTPKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  TextInputFormField(
                    textAlign: TextAlign.left,
                    controller: _otpController,
                    hintText: "Enter your OTP",
                    obscureText: true,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 16),
                    child: NLRaisedGradientRoundedButton(
                      child: Text(
                        "VERIFY",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      height: 40,
                      minWidth: 250,
                      onPressed: () {
                        NLDialog.showLoading(context);
                        _validateOTP();
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 16),
                    child: NLRaisedGradientRoundedButton(
                      child: Text(
                        "RESEND",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16
                        ),
                      ),
                      height: 40,
                      minWidth: 250,
                      onPressed: () {
                        NLDialog.showLoading(context);
                        setState(() {
                          isGotOTP = false;
                        });
                      },
                    ),
                  )
                ],
              ),
            ),
          );
  }


  void _validateOTP() async {
    var controller = OTPController();
    _otp.identifier = await DeviceId.getID;
    _otp.otp = _otpController.text;
    final prefs = await SharedPreferences.getInstance();
    controller.validateOTP(_otp).then((b) {
      if (b) {
        prefs.setString('email', _email.text);
        Navigator.of(context).pop();
        Navigator.of(context).pushNamed('/changepass');
      } else {
        Navigator.of(context).pop();
        NLDialog.showInfo(context, "Validate OTP Failed", "OTP is incorrect!");
      }
    });
  }

  void _getOTP() {
    var travelerController = TravellerController();
    var otpController = OTPController();
    travelerController.findByEmail(_email.text).then((data) {
      if (data == null) {
        Navigator.of(context).pop();
        NLDialog.showInfo(context, "Get OTP Failed!", "Email is incorrect!");
      } else {
        otpController.getOTP(_email.text, "Get OTP").then((otp) {
          Navigator.of(context).pop();
          _otp = otp;
          setState(() {
            isGotOTP = !isGotOTP;
          });
        });
      }
    });
  }
}
