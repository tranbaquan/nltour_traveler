import 'package:flutter/material.dart';
import 'package:nltour_traveler/ui/widget/nl_app_bar.dart';
import 'package:flutter_paystack/flutter_paystack.dart';

class PaymentDetailPage extends StatefulWidget {
  @override
  PaymentDetailPageState createState() {
    return new PaymentDetailPageState();
  }
}

class PaymentDetailPageState extends State<PaymentDetailPage> {
  var paystackPublicKey = 'pk_test_db4b8fa81b59123fb8f7d84eb36281dd680ed2e1';

  var paystackSecretKey = 'sk_test_8f82014842a14ebeaa1fce408ca5d1f6f02a576a';

  @override
  void initState() {
    PaystackPlugin.initialize(
        publicKey: paystackPublicKey, secretKey: paystackSecretKey);
    super.initState();
  }

  void charge() {
//    _formKey.currentState.save();
//    Charge charge = Charge()
//      ..amount = 10000
//      ..email = 'customer@email.com'
//      ..card = _getCardFromUI();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NLAppbar.buildAppbar(context, 'Payment'),
      body: Container(
        child: Text('Payment'),
      ),
    );
  }
}