import 'package:flutter/material.dart';
import 'package:nltour_traveler/supporter/validator.dart';
import 'package:nltour_traveler/ui/widget/nl_button.dart';
import 'package:nltour_traveler/ui/widget/nl_form.dart';

class ForgotPage extends StatefulWidget {
  @override
  ForgotPageState createState() {
    return new ForgotPageState();
  }
}

class ForgotPageState extends State<ForgotPage> {
  final _email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: buildBody(context),
    );
  }

  PreferredSize buildAppBar(BuildContext context){
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

  Widget buildBody(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Center(
        child: Column(
          children: <Widget>[
            TextInputForm(
              validator: Validator.validateEmail,
              textAlign: TextAlign.left,
              controller: _email,
              hintText: "Enter your email",
              keyboardType: TextInputType.emailAddress,
            ),
            RaisedGradientRoundedButton(
              child: Text("Send"),
              height: 40,
              minWidth: 250,
              onPressed: () {

              },
            ),
          ],
        ),
      ),
    );
  }
}
