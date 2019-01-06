import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nltour_traveler/controller/traveler_controller.dart';
import 'package:nltour_traveler/model/traveler.dart';
import 'package:nltour_traveler/ui/widget/nl_button.dart';
import 'package:nltour_traveler/ui/widget/nl_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InformationPage extends StatefulWidget {
  @override
  InformationPageState createState() {
    return new InformationPageState();
  }
}

class InformationPageState extends State<InformationPage> {
  Dialogs dialogs = Dialogs();
  bool isEnable = false;
  String gender = '';
  Traveler account = Traveler();

  List<RadioModel> sampleData = new List<RadioModel>();

  @override
  void initState() {
    super.initState();
    sampleData.add(new RadioModel(true, 'men'));
    sampleData.add(new RadioModel(false, 'women'));
    loadData();
  }

  Future<Traveler> loadData() async {
    final prefs = await SharedPreferences.getInstance();
    String email = prefs.getString('email');
    var travelerController = TravellerController();
    account = await travelerController.findByEmail(email);
    return account;
  }

  // ********************************* GENDER RADIO BUTTON *********************
  // ***************************************************************************
  // ***************************************************************************
  // ********************************* DATE TIME PICKER ************************
  DateTime _dateTime = new DateTime.now();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _dateTime,
        firstDate: DateTime(1970),
        lastDate: DateTime(2020));
    if (picked != null && picked != _dateTime) {
      setState(() {
        _dateTime = picked;
      });
    }
  }

  // ********************************* DATE TIME PICKER ************************
  // ***************************************************************************

  @override
  Widget build(BuildContext context) {
    final _editableButton = Container(
      width: MediaQuery.of(context).size.width,
      child: Align(
        alignment: Alignment.centerRight,
        child: isEnable
            ? SimpleRoundButton(
                textColor: Color(0xffffffff),
                btnText: 'SAVE',
                backgroundColor: Color(0xff008fe5),
                roundColor: Color(0xff008fe5),
                btnHeight: 40,
                btnWidth: 80,
                onPressed: () {
                  setState(() {
                    isEnable = !isEnable;
                  });
                },
              )
            : SimpleButton(
                textColor: Color(0xff006fb2),
                btnText: 'EDIT',
                onPress: () {
                  setState(() {
                    isEnable = !isEnable;
                  });
                },
              ),
      ),
    );

    final _avatar = Container(
      margin: EdgeInsets.only(bottom: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(42),
            child: new Image.network(
              account.avatar,
              fit: BoxFit.cover,
              height: 84,
              width: 84,
            ),
          ),
          Text(
            account.firstName + " " + account.lastName,
            style: TextStyle(
              fontFamily: 'Normal',
              fontSize: 20,
              color: Color(0xff000000),
            ),
          ),
          Text(
            account.email,
            style: TextStyle(
              fontFamily: 'Semilight',
              fontSize: 11,
              color: Color(0xff383838),
            ),
          ),
        ],
      ),
    );

    final _generalInf = Container(
      margin: EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 0,
      ),
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 0),
            child: Text(
              'General Information',
              style: TextStyle(
                  color: Color(0xff707070),
                  fontSize: 16,
                  fontFamily: 'Semilight'),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 18, vertical: 0),
            color: Color(0xffffffff),
            child: Row(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width / 3,
                  child: Text(
                    'First name',
                    style: TextStyle(
                        color: Color(0x80000000),
                        fontSize: 14,
                        fontFamily: 'Semilight'),
                  ),
                ),
                Expanded(
                  child: Container(
                    child: TextField(
                      enabled: isEnable,
                      style: TextStyle(
                        color: Color(0xff008fe5),
                        fontSize: 14.0,
                        fontFamily: 'Semilight',
                      ),

                      decoration: InputDecoration(
                        hintText: account.firstName,
                        hintStyle: TextStyle(
                          color: Color(0xff000000),
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 18, vertical: 0),
            color: Color(0xffffffff),
            child: Row(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width / 3,
                  child: Text(
                    'Last name',
                    style: TextStyle(
                        color: Color(0x80000000),
                        fontSize: 14,
                        fontFamily: 'Semilight'),
                  ),
                ),
                Expanded(
                  child: Container(
                    child: TextField(
                      enabled: isEnable,
                      style: TextStyle(
                        color: Color(0xff008fe5),
                        fontSize: 14.0,
                        fontFamily: 'Semilight',
                      ),

                      decoration: InputDecoration(
                        hintText: account.lastName,
                        hintStyle: TextStyle(
                          color: Color(0xff000000),
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: Color(0xffffffff),
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 18, vertical: 0),
            child: Row(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width / 3,
                  child: Text(
                    'Phone',
                    style: TextStyle(
                        color: Color(0x80000000),
                        fontSize: 14,
                        fontFamily: 'Semilight'),
                  ),
                ),
                Expanded(
                  child: Container(
                    child: TextField(
                      enabled: isEnable,
                      style: TextStyle(
                        color: Color(0xff008fe5),
                        fontSize: 14.0,
                        fontFamily: 'Semilight',
                      ),
                      decoration: InputDecoration(
                        hintText: '+84393452595',
                        hintStyle: TextStyle(
                          color: Color(0xff000000),
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: Color(0xffffffff),
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 18, vertical: 0),
            child: Row(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width / 3,
                  child: Text(
                    'Gender',
                    style: TextStyle(
                        color: Color(0x80000000),
                        fontSize: 14,
                        fontFamily: 'Semilight'),
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      InkWell(
                        child: RadioItemButton(sampleData[0]),
                        splashColor: Color(0xff008fe5),
                        onTap: () {
                          setState(() {
                            sampleData.forEach(
                                (element) => element.isSelected = false);
                            sampleData[0].isSelected = true;
                          });
                        },
                      ),
                      InkWell(
                        child: RadioItemButton(sampleData[1]),
                        splashColor: Color(0xff008fe5),
                        onTap: () {
                          setState(() {
                            sampleData.forEach(
                                (element) => element.isSelected = false);
                            sampleData[1].isSelected = true;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: Color(0xffffffff),
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 18, vertical: 0),
            child: Row(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width / 3,
                  child: Text(
                    'Birthday',
                    style: TextStyle(
                        color: Color(0x80000000),
                        fontSize: 14,
                        fontFamily: 'Semilight'),
                  ),
                ),
                Expanded(
                  child: Container(
                    child: TextField(
                      onTap: () => _selectDate(context),
                      enabled: isEnable,
                      style: TextStyle(
                        color: Color(0xff008fe5),
                        fontSize: 14.0,
                        fontFamily: 'Semilight',
                      ),
                      decoration: const InputDecoration(
                        hintText: '039.680.8818',
                        hintStyle: TextStyle(
                          color: Color(0xff000000),
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: Color(0xffffffff),
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 18, vertical: 0),
            child: Row(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width / 3,
                  child: Text(
                    'Personal ID',
                    style: TextStyle(
                        color: Color(0x80000000),
                        fontSize: 14,
                        fontFamily: 'Semilight'),
                  ),
                ),
                Expanded(
                  child: Container(
                    child: TextField(
//            onChanged: ,
                      enabled: isEnable,
                      style: TextStyle(
                        color: Color(0xff008fe5),
                        fontSize: 14.0,
                        fontFamily: 'Semilight',
                      ),
                      decoration: const InputDecoration(
                        hintText: '291152033',
                        hintStyle: TextStyle(
                          color: Color(0xff000000),
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: Color(0xffffffff),
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 18, vertical: 0),
            child: Row(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width / 3,
                  child: Text(
                    'Country',
                    style: TextStyle(
                        color: Color(0x80000000),
                        fontSize: 14,
                        fontFamily: 'Semilight'),
                  ),
                ),
                Expanded(
                  child: Container(
                    child: TextField(
//            onChanged: ,
                      enabled: isEnable,
                      style: TextStyle(
                        color: Color(0xff008fe5),
                        fontSize: 14.0,
                        fontFamily: 'Semilight',
                      ),
                      decoration: const InputDecoration(
                        hintText: 'Viet Nam',
                        hintStyle: TextStyle(
                          color: Color(0xff000000),
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: Color(0xffffffff),
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 18, vertical: 0),
            child: Row(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width / 3,
                  child: Text(
                    'Main languages',
                    style: TextStyle(
                        color: Color(0x80000000),
                        fontSize: 14,
                        fontFamily: 'Semilight'),
                  ),
                ),
                Expanded(
                  child: Container(
                    child: TextField(
//            onChanged: ,
                      enabled: isEnable,
                      style: TextStyle(
                        color: Color(0xff008fe5),
                        fontSize: 14.0,
                        fontFamily: 'Semilight',
                      ),
                      decoration: const InputDecoration(
                        hintText: 'English',
                        hintStyle: TextStyle(
                          color: Color(0xff000000),
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    String _password;
    final _passwordField = TextFormField(
      autocorrect: false,
      obscureText: true,
      decoration: InputDecoration(labelText: 'Password'),
      validator: (value) => value.isEmpty ? "Password can't be empty" : null,
      onSaved: (val) => _password = val,
    );
    String _passwordConfirm;
    final _passwordConfirmField = TextFormField(
        autocorrect: false,
        obscureText: true,
        decoration: InputDecoration(labelText: 'Retype Password'),
        validator: (value) => value.isEmpty ? "Password can't be empty" : null,
        onSaved: (val) => _passwordConfirm = val);

    final _confirmWidget = Container(
      child: SizedBox(
        child: Card(
          child: Form(
              autovalidate: true,
              child: Column(
                children: <Widget>[
                  _passwordField,
                  _passwordConfirmField,
                ],
              )),
        ),
      ),
    );

    final _secureInf = Container(
      margin: EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 0,
      ),
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 18),
            child: Text(
              'Security Information',
              style: TextStyle(
                  color: Color(0xff707070),
                  fontSize: 16,
                  fontFamily: 'Semilight'),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 18, vertical: 0),
            color: Color(0xffffffff),
            child: Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                  child: InkWell(
                    onTap: () {
                      dialogs.confirm2(context, 'Change Your Password',
                          _confirmWidget, 'NO', 'CHANGE');
                    },
                    child: Text(
                      'Change password',
                      style: TextStyle(
                          color: Color(0xff008fe5),
                          fontSize: 14,
                          fontFamily: 'Normal'),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 3),
            child: Text(
              'TRUSTED EMAIL',
              style: TextStyle(
                color: Color(0xff88888d),
                fontSize: 11,
                fontFamily: 'Semilight',
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 18, vertical: 0),
            color: Color(0xffffffff),
            child: Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                  child: Text(
                    'dcthien.it.1997@gmail.com',
                    style: TextStyle(
                        color: Color(0xff000000),
                        fontSize: 14,
                        fontFamily: 'Semilight'),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 0),
            child: Text(
              'Trusted email is used to verify your identity when signing in'
                  'and to help recover your account if you have'
                  'forgotten your password.',
              style: TextStyle(
                fontSize: 11,
                color: Color(0xff88888d),
                fontFamily: 'Semilight',
              ),
            ),
          ),
        ],
      ),
    );

    return SingleChildScrollView(
      child: Container(
        color: Color(0xffefeff4),
        padding: EdgeInsets.only(bottom: 9),
        child: Center(
          child: FutureBuilder(
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    _editableButton,
                    _avatar,
                    _generalInf,
                    _secureInf,
                  ],
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
