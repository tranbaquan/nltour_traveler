import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:intl/intl.dart';
import 'package:nltour_traveler/controller/auto_complete_api.dart';
import 'package:nltour_traveler/controller/traveler_controller.dart';
import 'package:nltour_traveler/model/collaborator/type.dart';
import 'package:nltour_traveler/model/traveler/traveler.dart';
import 'package:nltour_traveler/supporter/validator/validator.dart';
import 'package:nltour_traveler/ui/widget/nl_button.dart';
import 'package:nltour_traveler/ui/widget/nl_dialog.dart';
import 'package:nltour_traveler/utils/dialog.dart';
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
  Traveler account = Traveler();

  final _password = TextEditingController();
  final _reenterPassword = TextEditingController();
  final _oldPassword = TextEditingController();
  final _firstName = TextEditingController();
  final _lastName = TextEditingController();
  final _personalId = TextEditingController();
  final _country = TextEditingController();
  final _languages = TextEditingController();
  final _dob = TextEditingController();
  final dateFormat = DateFormat('MMM dd, yyyy');
  final autoComplete = CountryAutoComplete();

  Future<Traveler> loadData() async {
    final prefs = await SharedPreferences.getInstance();
    String email = prefs.getString('email');
    var travelerController = TravellerController();
    return travelerController.findByEmail(email).then((data) {
      print(json.encode(data));
      if (data != null) {
        account = data;
        _password.text = account.password;
        _reenterPassword.text = account.password;
        _firstName.text = account.firstName;
        _lastName.text = account.lastName;
        _personalId.text = account.personalID;
        _country.text = account.address.country;
        _languages.text = account.languages.primaryLanguage;
        _dob.text = dateFormat.format(account.dob);
        return account;
      } else {
        return null;
      }
    });
  }

  Future<Null> _selectDate(BuildContext context) async {
    showDatePicker(
      context: context,
      initialDate: account.dob,
      firstDate: DateTime(1970),
      lastDate: DateTime(2020),
    ).then((data) {
      if (data != null) {
        setState(() {
          account.dob = data;
          _dob.text = dateFormat.format(account.dob);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final _editableButton = Container(
      child: isEnable
          ? NLSimpleRoundedButton(
              textColor: Color(0xffffffff),
              btnText: 'SAVE',
              backgroundColor: Color(0xff008fe5),
              roundColor: Color(0xff008fe5),
              btnHeight: 30,
              btnWidth: 80,
              onPressed: () {
                NLDialog.showLoading(context);
                updateUser().then((data) {
                  Navigator.of(context).pop();
                  setState(() {
                    isEnable = !isEnable;
                  });
                });
              },
            )
          : NLSimpleRoundedButton(
              textColor: Color(0xff006fb2),
              btnText: 'EDIT',
              backgroundColor: Color(0xffffffff),
              roundColor: Color(0xff008fe5),
              btnHeight: 30,
              btnWidth: 80,
              onPressed: () {
                setState(() {
                  isEnable = !isEnable;
                });
              },
            ),
    );

    final _cancelButton = Container(
      margin: EdgeInsets.only(left: 5),
      child: NLSimpleRoundedButton(
        textColor: Color(0xff006fb2),
        btnText: 'CANCEL',
        backgroundColor: Color(0xffffffff),
        roundColor: Color(0xff008fe5),
        btnHeight: 30,
        btnWidth: 80,
        onPressed: () {
          setState(() {
            isEnable = !isEnable;
          });
        },
      ),
    );

    final _oldPasswordField = TextFormField(
      autocorrect: false,
      obscureText: true,
      controller: _oldPassword,
      decoration: InputDecoration(labelText: 'Old password'),
      validator: Validator.validatePassword,
    );

    final _passwordField = TextFormField(
      autocorrect: false,
      obscureText: true,
      controller: _password,
      decoration: InputDecoration(labelText: 'Password'),
      validator: Validator.validatePassword,
    );
    final _passwordConfirmField = TextFormField(
      autocorrect: false,
      obscureText: true,
      controller: _reenterPassword,
      decoration: InputDecoration(labelText: 'Retype Password'),
      validator: (value) =>
          value != _password.text ? "Password not match!" : null,
    );

    final _confirmWidget = Container(
      child: SizedBox(
        child: Card(
          child: Form(
              autovalidate: true,
              child: Column(
                children: <Widget>[
                  _oldPasswordField,
                  _passwordField,
                  _passwordConfirmField,
                ],
              )),
        ),
      ),
    );

    return Scaffold(
      body: SingleChildScrollView(
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
                      Container(
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
                        padding: EdgeInsets.only(top: 30),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            ClipRRect(
                              borderRadius: BorderRadius.circular(42),
                              child: new Image.network(
                                snapshot.data.avatar,
                                fit: BoxFit.cover,
                                height: 84,
                                width: 84,
                              ),
                            ),
                            Text(
                              snapshot.data.firstName +
                                  " " +
                                  snapshot.data.lastName,
                              style: TextStyle(
                                fontFamily: 'Normal',
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              snapshot.data.email,
                              style: TextStyle(
                                fontFamily: 'Semilight',
                                fontSize: 11,
                                color: Colors.grey[200],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 18),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Expanded(
                                    child: Container(),
                                  ),
                                  _editableButton,
                                  isEnable ? _cancelButton : Container(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.only(top: 10),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 18),
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
                              padding: EdgeInsets.symmetric(
                                  horizontal: 18, vertical: 0),
                              color: Color(0xffffffff),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 3,
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
                                      child: TextFormField(
                                        enabled: isEnable,
                                        style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 14.0,
                                          fontFamily: 'Semilight',
                                        ),
                                        controller: _firstName,
                                        validator: Validator.notEmpty,
                                        decoration: InputDecoration(
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
                              padding: EdgeInsets.symmetric(
                                  horizontal: 18, vertical: 0),
                              color: Color(0xffffffff),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 3,
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
                                      child: TextFormField(
                                        enabled: isEnable,
                                        style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 14.0,
                                          fontFamily: 'Semilight',
                                        ),
                                        validator: Validator.notEmpty,
                                        controller: _lastName,
                                        decoration: InputDecoration(
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
                              padding: EdgeInsets.symmetric(
                                  horizontal: 18, vertical: 0),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 3,
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
                                      child: TextFormField(
                                        enabled: isEnable,
                                        style: TextStyle(
                                          color: Color(0xff008fe5),
                                          fontSize: 14.0,
                                          fontFamily: 'Semilight',
                                        ),
                                        validator: Validator.notEmpty,
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
                              padding: EdgeInsets.symmetric(
                                  horizontal: 18, vertical: 0),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 3,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        InkWell(
                                          child: NLRadioItemButton(
                                            RadioModel(
                                                account.gender == Gender.MALE
                                                    ? true
                                                    : false,
                                                'men'),
                                          ),
                                          splashColor: Color(0xff008fe5),
                                        ),
                                        InkWell(
                                          child: NLRadioItemButton(
                                            RadioModel(
                                                account.gender == Gender.FEMALE
                                                    ? true
                                                    : false,
                                                'women'),
                                          ),
                                          splashColor: Color(0xff008fe5),
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
                              padding: EdgeInsets.symmetric(
                                  horizontal: 18, vertical: 0),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 3,
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
                                          color: Colors.black87,
                                          fontSize: 14.0,
                                          fontFamily: 'Semilight',
                                        ),
                                        controller: _dob,
                                        decoration: InputDecoration(
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
                              padding: EdgeInsets.symmetric(
                                  horizontal: 18, vertical: 0),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 3,
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
                                      child: TextFormField(
                                        enabled: isEnable,
                                        validator: Validator.notEmpty,
                                        style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 14.0,
                                          fontFamily: 'Semilight',
                                        ),
                                        controller: _personalId,
                                        decoration: InputDecoration(
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
                              padding: EdgeInsets.symmetric(
                                  horizontal: 18, vertical: 0),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 3,
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
                                      child: TypeAheadField(
                                        textFieldConfiguration:
                                            TextFieldConfiguration(
                                          enabled: isEnable,
                                          style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 14.0,
                                            fontFamily: 'Semilight',
                                          ),
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                          ),
                                          controller: _country,
                                        ),
                                        suggestionsCallback: (pattern) async {
                                          return await autoComplete
                                              .getCountries(pattern);
                                        },
                                        itemBuilder: (context, suggestion) {
                                          return ListTile(
                                            title: Text(suggestion),
                                          );
                                        },
                                        transitionBuilder: (context,
                                            suggestionsBox, controller) {
                                          return suggestionsBox;
                                        },
                                        onSuggestionSelected: (suggestion) {
                                          _country.text = suggestion;
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              color: Color(0xffffffff),
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 18, vertical: 0),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 3,
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
                                      child: TypeAheadField(
                                        textFieldConfiguration:
                                            TextFieldConfiguration(
                                          enabled: isEnable,
                                          style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 14.0,
                                            fontFamily: 'Semilight',
                                          ),
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                          ),
                                          controller: _languages,
                                        ),
                                        suggestionsCallback: (pattern) async {
                                          return await autoComplete
                                              .getCountries(pattern);
                                        },
                                        itemBuilder: (context, suggestion) {
                                          return ListTile(
                                            title: Text(suggestion),
                                          );
                                        },
                                        transitionBuilder: (context,
                                            suggestionsBox, controller) {
                                          return suggestionsBox;
                                        },
                                        onSuggestionSelected: (suggestion) {
                                          _languages.text = suggestion;
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
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
                              padding: const EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 18),
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
                              padding: EdgeInsets.symmetric(
                                  horizontal: 18, vertical: 0),
                              color: Color(0xffffffff),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 0),
                                    child: InkWell(
                                      onTap: () {
                                        dialogs.confirm3(
                                            context,
                                            'Change Your Password',
                                            _confirmWidget,
                                            'NO', () {
                                          Navigator.of(context).pop();
                                          changePass();
                                        });
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
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 18, vertical: 3),
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
                              padding: EdgeInsets.symmetric(
                                  horizontal: 18, vertical: 0),
                              color: Color(0xffffffff),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 0),
                                    child: Text(
                                      account.email,
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
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 18, vertical: 0),
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
                      ),
                    ],
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
              future: loadData(),
            ),
          ),
        ),
      ),
    );
  }

  Future<Traveler> updateUser() async {
    var controller = TravellerController();
    final prefs = await SharedPreferences.getInstance();
    account.languages.primaryLanguage = _languages.text.isEmpty
        ? account.languages.primaryLanguage
        : _languages.text;
    account.address.country =
        _country.text.isEmpty ? account.address.country : _country.text;
    account.personalID =
        _personalId.text.isEmpty ? account.personalID : _personalId.text;
    account.firstName =
        _firstName.text.isEmpty ? account.firstName : _firstName.text;
    account.lastName =
        _lastName.text.isEmpty ? account.lastName : _lastName.text;

    return controller.update(account).then((data) {
      print(json.encode(data));
      if (data != null) {
        prefs.setBool('logged', true);
        prefs.setString('email', data.email);
        prefs.setString('avatar', data.avatar);
        prefs.setString('firstName', data.firstName);
        prefs.setString('lastName', data.lastName);
        setState(() {
          account = data;
          return account;
        });
      }
    });
  }

  void changePass() {
    NLDialog.showLoading(context);
    TravellerController controller = TravellerController();
    controller
        .changePassword1(account.email, _oldPassword.text, _password.text)
        .then((data) {
      Navigator.pop(context);
      print(account.email);
      print(_oldPassword.text);
      print(_password.text);
      if (data != null) {
        setState(() {
          account = data;
        });
      } else {
        NLDialog.showInfo(context, 'Change password failed', 'Oops.. sorry!');
      }
    });
  }
}
