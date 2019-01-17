import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:nltour_traveler/ui/widget/nl_app_bar.dart';

class PaymentPage extends StatefulWidget {
  @override
  PaymentPageState createState() {
    return new PaymentPageState();
  }
}

class PaymentPageState extends State<PaymentPage> {
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