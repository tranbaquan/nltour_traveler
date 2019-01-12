import 'package:flutter/material.dart';
import 'package:nltour_traveler/controller/traveler_controller.dart';
import 'package:nltour_traveler/model/traveler/traveler.dart';
import 'package:nltour_traveler/ui/widget/nl_app_bar.dart';
import 'package:nltour_traveler/ui/widget/nl_menu_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MessageListPage extends StatefulWidget {
  @override
  MessageListPageState createState() {
    return new MessageListPageState();
  }
}

class MessageListPageState extends State<MessageListPage> {
  Traveler me;
  CollectionReference messageListReference;

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NLAppbar.buildAppbar(context, 'Message'),
      drawer: Drawer(
        child: NLMenuCard(),
      ),
      body: buildBody(context),
    );
  }

  buildBody(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: StreamBuilder<QuerySnapshot>(
        stream: messageListReference.snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot> snapshot) {
        },
      ),
    );
  }

  Future getData() async {
    final prefs = await SharedPreferences.getInstance();
    String email = prefs.getString('email');
    TravellerController controller = TravellerController();
    controller.findByEmail(email).then((data) {
      me = data;
      messageListReference = messageListReference = Firestore.instance.collection('message/' + me.personalID);
    });
  }
}
