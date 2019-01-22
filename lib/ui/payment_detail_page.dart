import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:http/http.dart' as http;
import 'package:nltour_traveler/controller/tour_controller.dart';
import 'package:nltour_traveler/model/tour/tour.dart';
import 'package:nltour_traveler/ui/widget/nl_app_bar.dart';
import 'package:nltour_traveler/ui/widget/nl_button.dart';
import 'package:nltour_traveler/utils/dialog.dart';

String backendUrl = 'https://nltour.herokuapp.com/';

String paystackPublicKey = 'pk_test_db4b8fa81b59123fb8f7d84eb36281dd680ed2e1';
String paystackSecretKey = 'sk_test_8f82014842a14ebeaa1fce408ca5d1f6f02a576a';

class PaymentDetailPage extends StatefulWidget {
  final Tour tour;

  const PaymentDetailPage({Key key, this.tour}) : super(key: key);

  @override
  PaymentDetailPageState createState() {
    return new PaymentDetailPageState();
  }
}

class PaymentDetailPageState extends State<PaymentDetailPage> {
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  final CheckoutMethod _method = CheckoutMethod.card;

  String _cardNumber;
  String _cvv;
  int _expiryMonth = 0;
  int _expiryYear = 0;

  @override
  void initState() {
    PaystackPlugin.initialize(
        publicKey: paystackPublicKey, secretKey: paystackSecretKey);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: NLAppbar.buildAppbar(context, 'Payment'),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Current Bill Amount',
                  style: TextStyle(
                    fontFamily: 'Normal',
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text(
                  '\$' + widget.tour.price.toString(),
                  style: TextStyle(
                    fontFamily: 'Normal',
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(
                          color: Color(0xFF008fe5),
                          width: 1,
                        ),
                      ),
                      hintText: 'Card Number'),
                  onSaved: (String value) => _cardNumber = value,
                  keyboardType: TextInputType.numberWithOptions(
                      signed: false, decimal: false),
                  style: TextStyle(
                    color: Color(0xFF008fe5),
                    fontSize: 18,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(
                                color: Color(0xFF008fe5),
                                width: 2,
                              ),
                            ),
                            hintText: 'MMYYYY'),
                        onSaved: (String value) {
                          _expiryMonth = _toMonth(value);
                          _expiryYear = _toYear(value);
                        },
                        style: TextStyle(
                          color: Color(0xFF008fe5),
                          fontSize: 18,
                        ),
                        keyboardType: TextInputType.datetime,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(
                                color: Color(0xFF008fe5),
                                width: 2,
                              ),
                            ),
                            hintText: 'CVV'),
                        onSaved: (String value) => _cvv = value,
                        keyboardType: TextInputType.numberWithOptions(
                            decimal: false, signed: false),
                        style: TextStyle(
                          color: Color(0xFF008fe5),
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                NLRaisedGradientRoundedButton(
                  minWidth: double.infinity,
                  onPressed: () {
                    _handleCheckout();
                  },
                  child: Text(
                    'Pay',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                        fontFamily: 'Normal'),
                  ),
                  height: 50,
                ),
                SizedBox(
                  height: 20,
                ),
                RaisedButton(
                  color: Color(0xff00294f),
                  onPressed: () {},
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        'secured by ',
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        'paystack',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _handleCheckout() async {
    _formKey.currentState.save();
    Charge charge = Charge()
      ..amount = widget.tour.price.round() * 1000
      ..email = widget.tour.traveler.email
      ..card = _getCardFromUI();

    NLDialog.showLoading(context);

//    var accessCode = await _fetchAccessCodeFrmServer(_getReference());
//    charge.accessCode = accessCode;
    charge.reference = _getReference();

    Navigator.pop(context);

    CheckoutResponse response = await PaystackPlugin.checkout(context,
        method: _method, charge: charge, fullscreen: false);
    NLDialog.showLoading(context);
    if(response.status) {
      Tour t = widget.tour;
      t.paid = true;
      print(json.encode(t));
      TourController controller = TourController();
      await controller.updateTour(t);
    }
    Navigator.pop(context);
    _updateStatus(response.reference, '$response');
  }

  _startAfreshCharge() async {
    _formKey.currentState.save();

    Charge charge = Charge();
    charge.card = _getCardFromUI();

    // Perform transaction/initialize on Paystack server to get an access code
    // documentation: https://developers.paystack.co/reference#initialize-a-transaction
    charge.accessCode = await _fetchAccessCodeFrmServer(_getReference());
    _chargeCard(charge);
  }

  _chargeCard(Charge charge) {
    handleBeforeValidate(Transaction transaction) {
      _updateStatus(transaction.reference, 'validating...');
    }

    handleOnError(Object e, Transaction transaction) {
      if (e is ExpiredAccessCodeException) {
        _startAfreshCharge();
        _chargeCard(charge);
        return;
      }

      if (transaction.reference != null) {
        _verifyOnServer(transaction.reference);
      } else {
        _updateStatus(transaction.reference, e.toString());
      }
    }

    handleOnSuccess(Transaction transaction) {
      _verifyOnServer(transaction.reference);
    }

    PaystackPlugin.chargeCard(context,
        charge: charge,
        beforeValidate: (transaction) => handleBeforeValidate(transaction),
        onSuccess: (transaction) => handleOnSuccess(transaction),
        onError: (error, transaction) => handleOnError(error, transaction));
  }

  String _getReference() {
    String platform;
    if (Platform.isIOS) {
      platform = 'iOS';
    } else {
      platform = 'Android';
    }

    return 'ChargedFrom${platform}_${DateTime.now().millisecondsSinceEpoch}';
  }

  PaymentCard _getCardFromUI() {
    return PaymentCard(
      number: _cardNumber,
      cvc: _cvv,
      expiryMonth: _expiryMonth,
      expiryYear: _expiryYear,
    );
  }

  Future<String> _fetchAccessCodeFrmServer(String reference) async {
    String url = '$backendUrl/new-access-code';
    String accessCode;
    try {
      http.Response response = await http.get(url);
      accessCode = response.body;
      print('Response for access code = $accessCode');
    } catch (e) {
      _updateStatus(
          reference,
          'There was a problem getting a new access code form'
          ' the backend: $e');
    }
    return accessCode;
  }

  void _verifyOnServer(String reference) async {
    _updateStatus(reference, 'Verifying...');
    String url = '$backendUrl/verify/$reference';
    try {
      http.Response response = await http.get(url);
      var body = response.body;
      _updateStatus(reference, body);
    } catch (e) {
      _updateStatus(
          reference,
          'There was a problem verifying %s on the backend: '
          '$reference $e');
    }
  }

  _updateStatus(String reference, String message) {
    _showMessage('Reference: $reference \n\ Response: $message',
        const Duration(seconds: 7));
  }

  _showMessage(String message,
      [Duration duration = const Duration(seconds: 10)]) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(message),
      duration: duration,
      action: new SnackBarAction(
          label: 'CLOSE',
          onPressed: () {
            _scaffoldKey.currentState.removeCurrentSnackBar();
            Navigator.pushReplacementNamed(context, '/home');
          }),
    ));
  }

  int _toMonth(String value) {
    print(value.substring(0, 2));
    return int.parse(value.substring(0, 2));
  }

  int _toYear(String value) {
    print(value.substring(4));
    return int.parse(value.substring(4));
  }
}
