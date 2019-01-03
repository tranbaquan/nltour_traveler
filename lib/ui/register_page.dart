import 'dart:io';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nltour_traveler/controller/auto_complete_api.dart';
import 'package:nltour_traveler/controller/traveler_controller.dart';
import 'package:nltour_traveler/model/address.dart';
import 'package:nltour_traveler/model/languages.dart';
import 'package:nltour_traveler/model/traveler.dart';
import 'package:nltour_traveler/model/type.dart';
import 'package:nltour_traveler/supporter/validator.dart';
import 'package:nltour_traveler/ui/widget/nl_button.dart';
import 'package:nltour_traveler/ui/widget/nl_form.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterPage extends StatefulWidget {
  @override
  RegisterPageState createState() {
    return new RegisterPageState();
  }
}

class RegisterPageState extends State<RegisterPage> {
  int _currentStep = 0;
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _reenterPassword = TextEditingController();
  final _firstName = TextEditingController();
  final _lastName = TextEditingController();
  final _personalId = TextEditingController();
  final _country = TextEditingController();
  final _languages = TextEditingController();
  List _genders = [Gender.MALE, Gender.FEMALE];
  Gender _currentGender;
  var traveler = Traveler();
  File _image;
  final dateFormat = DateFormat('MMM dd, yyyy');
  DateTime _date;
  final autoComplete = CountryAutoComplete();

  @override
  void initState() {
    _currentGender = _genders[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: buildAppBar(context),
      body: buildRegisterForm(context),
    );
  }

  List<Step> _step() {
    List<Step> step = [
      Step(
        title: Text('Email'),
        content: TextInputForm(
          controller: _email,
          validator: Validator.validateEmail,
          keyboardType: TextInputType.emailAddress,
          textAlign: TextAlign.left,
          hintText: "Enter your email",
        ),
        isActive: _currentStep >= 0,
        state: StepState.indexed,
      ),
      Step(
          title: Text('Password'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextInputForm(
                controller: _password,
                validator: Validator.validatePassword,
                textAlign: TextAlign.left,
                obscureText: true,
                hintText: "Enter your password",
              ),
              TextInputForm(
                controller: _reenterPassword,
                validator: (value) {
                  if (value != _password.text) {
                    return "Password is not match!";
                  }
                },
                textAlign: TextAlign.left,
                obscureText: true,
                hintText: "Re-enter your password",
              ),
            ],
          ),
          isActive: _currentStep >= 1,
          state: StepState.indexed),
      Step(
          title: Text('Personal Information'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: 100,
                    child: TextInputForm(
                      hintText: 'First Name',
                      validator: Validator.notEmpty,
                      controller: _firstName,
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Container(
                    width: 150,
                    child: TextInputForm(
                      hintText: 'Last Name',
                      validator: Validator.notEmpty,
                      controller: _lastName,
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
              TextInputForm(
                hintText: 'Personal Id',
                validator: Validator.notEmpty,
                controller: _personalId,
                textAlign: TextAlign.left,
              ),
              Row(
                children: <Widget>[
                  Text(
                    'Male',
                  ),
                  Radio<Gender>(
                    value: Gender.MALE,
                    groupValue: _currentGender,
                    activeColor: Color(0xFF008fe5),
                    onChanged: (value) {
                      setState(() {
                        _currentGender = value;
                      });
                    },
                  ),
                  Text(
                    'Female',
                  ),
                  Radio<Gender>(
                    value: Gender.FEMALE,
                    activeColor: Color(0xFF008fe5),
                    groupValue: _currentGender,
                    onChanged: (value) {
                      setState(() {
                        _currentGender = value;
                      });
                    },
                  ),
                ],
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Container(
                  width: 150,
                  child: DateTimePickerFormField(
                    format: dateFormat,
                    decoration: InputDecoration(
                      hintText: "Birthday",
                    ),
                    dateOnly: true,
                    editable: false,
                    onChanged: (dt) => setState(() => _date = dt),
                    validator: (date) {
                      print(date);
                      return date == null ? '' : null;
                    },
                  ),
                ),
              ),
              TypeAheadField(
                textFieldConfiguration: TextFieldConfiguration(
                  decoration: InputDecoration(hintText: 'Enter your country'),
                  controller: _country,
                ),
                suggestionsCallback: (pattern) async {
                  return await autoComplete.getCountries(pattern);
                },
                itemBuilder: (context, suggestion) {
                  return ListTile(
                    title: Text(suggestion),
                  );
                },
                transitionBuilder: (context, suggestionsBox, controller) {
                  return suggestionsBox;
                },
                onSuggestionSelected: (suggestion) {
                  _country.text = suggestion;
                },
              ),
              TypeAheadField(
                textFieldConfiguration: TextFieldConfiguration(
                  decoration: InputDecoration(hintText: 'Enter your languages'),
                  controller: _languages,
                ),
                suggestionsCallback: (pattern) async {
                  return await autoComplete.getCountries(pattern);
                },
                itemBuilder: (context, suggestion) {
                  return ListTile(
                    title: Text(suggestion),
                  );
                },
                transitionBuilder: (context, suggestionsBox, controller) {
                  return suggestionsBox;
                },
                onSuggestionSelected: (suggestion) {
                  _languages.text = suggestion;
                },
              ),
            ],
          ),
          isActive: _currentStep >= 2,
          state: StepState.indexed),
      Step(
          title: Text('Avatar'),
          content: Center(
            child: _image == null
                ? Container(
                    alignment: Alignment.topLeft,
                    child: RaisedOutlineRoundedButton(
                      height: 40,
                      minWidth: 0,
                      onPressed: () {
                        getImage();
                      },
                      child: Text(
                        'Add Photo',
                        style: TextStyle(
                          color: Color(0xFF008fe5),
                        ),
                      ),
                    ),
                  )
                : Container(
                    alignment: Alignment.topLeft,
                    child: Stack(
                      alignment: AlignmentDirectional(1.5, -1.5),
                      children: <Widget>[
                        Image.file(
                          _image,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              _image = null;
                            });
                          },
                          icon: Icon(
                            Icons.clear,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
          ),
          isActive: _currentStep >= 3,
          state: StepState.complete),
    ];
    return step;
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

  Widget buildRegisterForm(BuildContext context) {
    var stepper = Stepper(
      steps: _step(),
      currentStep: this._currentStep,
      onStepContinue: () {
        return _continue();
      },
      onStepCancel: () {
        setState(() {
          if (this._currentStep > 0) {
            this._currentStep -= 1;
          } else {
            this._currentStep = 0;
          }
        });
      },
    );

    return Form(
      child: stepper,
      autovalidate: true,
    );
  }

  void _continue() async {
    var controller = TravellerController();
    print(_currentStep);
    switch (_currentStep) {
      case 0:
        if (Validator.validateEmail(_email.text) != null) {
          return null;
        } else {
          _onLoading();
          await controller.findByEmail(_email.text).then((t) {
            if (t == null) {
              Navigator.of(context).pop();
              setState(() {
                traveler.email = _email.text;
                _currentStep++;
              });
            } else {
              Navigator.of(context).pop();
            }
          });
        }
        break;
      case 1:
        if (!Validator.isMatch(_password.text, _reenterPassword.text)) {
          return null;
        } else {
          setState(() {
            traveler.password = _password.text;
            _currentStep++;
          });
        }
        break;
      case 2:
        _onLoading();
        if (_firstName.text == null ||
            _firstName.text.isEmpty ||
            _lastName.text == null ||
            _lastName.text.isEmpty ||
            _personalId.text == null ||
            _personalId.text.isEmpty ||
            _date == null ||
            _country.text == null ||
            _country.text.isEmpty ||
            _languages.text == null ||
            _languages.text.isEmpty) {
          return null;
        } else {
          setState(() {
            traveler.firstName = _firstName.text;
            traveler.lastName = _lastName.text;
            traveler.personalID = _personalId.text;
            traveler.dob = _date;
            traveler.address = Address(address: "", country: _country.text);
            traveler.languages = Languages(primaryLanguage: _languages.text);
            traveler.gender = _currentGender;
            _currentStep++;
          });
        }
        Navigator.of(context).pop();
        break;
      case 3:
        if (_image == null) {
          return null;
        } else {
          _onLoading();
          final StorageReference storage = FirebaseStorage.instance
              .ref()
              .child('photos')
              .child(DateTime.now().millisecondsSinceEpoch.toString() +
                  "_" +
                  path.basename(_image.path));
          final StorageUploadTask task = storage.putFile(_image);
          StorageTaskSnapshot taskSnapshot = await task.onComplete;
          String downloadUrl = await taskSnapshot.ref.getDownloadURL();
          setState(() {
            traveler.avatar = downloadUrl;
            createUser();
          });
          Navigator.of(context).pop();
        }
        break;
    }
  }

  void _onLoading() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return new Center(
          child: new CircularProgressIndicator(),
        );
      },
    );
  }

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  Future createUser() async {
    var controller =TravellerController();
    final prefs = await SharedPreferences.getInstance();
    controller.create(traveler).then((data) {
      prefs.setBool('logged', true);
      prefs.setString('email', data.email);
      Navigator.of(context).pushReplacementNamed('/');
    });
  }
}
