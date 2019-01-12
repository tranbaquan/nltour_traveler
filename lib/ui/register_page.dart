import 'dart:io';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nltour_traveler/controller/auto_complete_api.dart';
import 'package:nltour_traveler/controller/traveler_controller.dart';
import 'package:nltour_traveler/model/common/address.dart';
import 'package:nltour_traveler/model/common/languages.dart';
import 'package:nltour_traveler/model/traveler/traveler.dart';
import 'package:nltour_traveler/model/collaborator/type.dart';
import 'package:nltour_traveler/supporter/validator/validator.dart';
import 'package:nltour_traveler/ui/widget/nl_app_bar.dart';
import 'package:nltour_traveler/ui/widget/nl_button.dart';
import 'package:nltour_traveler/ui/widget/nl_form_field.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:nltour_traveler/utils/dialog.dart';
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
  List _genders = [Gender.MALE, Gender.FEMALE];
  Gender _currentGender;
  DateTime _date;
  File _image;
  Traveler traveler;

  final _email = TextEditingController();
  final _password = TextEditingController();
  final _reenterPassword = TextEditingController();
  final _firstName = TextEditingController();
  final _lastName = TextEditingController();
  final _personalId = TextEditingController();
  final _phoneNumber = TextEditingController();
  final _country = TextEditingController();
  final _languages = TextEditingController();
  final dateFormat = DateFormat('MMM dd, yyyy');
  final autoComplete = CountryAutoComplete();

  final GlobalKey<FormState> _emailForm = GlobalKey<FormState>();
  final GlobalKey<FormState> _passwordForm = GlobalKey<FormState>();
  final GlobalKey<FormState> _infoForm = GlobalKey<FormState>();

  @override
  void initState() {
    _currentGender = _genders[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: NLAppbar.buildAppbar(context, 'Create An Account'),
      body: buildRegisterForm(context),
    );
  }

  List<Step> _step() {
    List<Step> step = [
      Step(
        title: Text('Email'),
        content: Form(
          autovalidate: true,
          key: _emailForm,
          child: TextInputFormField(
            controller: _email,
            validator: Validator.validateEmail,
            keyboardType: TextInputType.emailAddress,
            textAlign: TextAlign.left,
            hintText: "Enter your email",
          ),
        ),
        isActive: _currentStep >= 0,
        state: StepState.indexed,
      ),
      Step(
          title: Text('Password'),
          content: Form(
            autovalidate: true,
            key: _passwordForm,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextInputFormField(
                  controller: _password,
                  validator: Validator.validatePassword,
                  textAlign: TextAlign.left,
                  obscureText: true,
                  hintText: "Enter your password",
                ),
                TextInputFormField(
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
          ),
          isActive: _currentStep >= 1,
          state: StepState.indexed),
      Step(
          title: Text('Personal Information'),
          content: Form(
            autovalidate: true,
            key: _infoForm,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: 100,
                      margin: EdgeInsets.only(right: 16),
                      child: TextInputFormField(
                        hintText: 'First Name',
                        validator: Validator.notEmpty,
                        controller: _firstName,
                        textAlign: TextAlign.left,
                        textCapitalization: TextCapitalization.words,
                      ),
                    ),
                    Expanded(
                      child: TextInputFormField(
                        hintText: 'Last Name',
                        validator: Validator.notEmpty,
                        controller: _lastName,
                        textAlign: TextAlign.left,
                        textCapitalization: TextCapitalization.words,
                      ),
                    ),
                  ],
                ),
                TextInputFormField(
                  hintText: 'Personal Id',
                  validator: Validator.notEmpty,
                  controller: _personalId,
                  textAlign: TextAlign.left,
                ),
                TextInputFormField(
                  hintText: 'Phone number',
                  validator: Validator.notEmpty,
                  controller: _phoneNumber,
                  textAlign: TextAlign.left,
                  keyboardType: TextInputType.number,
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
                DateTimePickerFormField(
                  format: dateFormat,
                  decoration: InputDecoration(
                    hintText: "Birthday",
                  ),
                  dateOnly: true,
                  editable: false,
                  onChanged: (date) => setState(() => _date = date),
                  validator: (date) {
                    return date == null ? 'Please enter your birthday' : null;
                  },
                ),
                TypeAheadFormField(
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
                  validator: Validator.notEmpty,
                ),
                TypeAheadFormField(
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
                  noItemsFoundBuilder: (context) {
                    return Text('No suggestions found!');
                  },
                  transitionBuilder: (context, suggestionsBox, controller) {
                    return suggestionsBox;
                  },
                  onSuggestionSelected: (suggestion) {
                    _languages.text = suggestion;
                  },
                  validator: Validator.notEmpty,
                ),
              ],
            ),
          ),
          isActive: _currentStep >= 2,
          state: StepState.indexed),
      Step(
          title: Text('Avatar'),
          content: Center(
            child: _image == null
                ? Container(
                    alignment: Alignment.topLeft,
                    child: NLRaisedOutlineButton(
                      height: 40,
                      minWidth: 0,
                      onPressed: () {
                        getImage();
                      },
                      color: Colors.white,
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
          NLDialog.showLoading(context);
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
        NLDialog.showLoading(context);
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
          NLDialog.showLoading(context);
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
      prefs.setString('avatar', data.avatar);
      prefs.setString('firstName', data.firstName);
      prefs.setString('lastName', data.lastName);
      Navigator.of(context).pushReplacementNamed('/');
    });
  }
}
