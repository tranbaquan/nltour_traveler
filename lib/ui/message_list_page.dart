import 'package:flutter/material.dart';
import 'package:nltour_traveler/ui/widget/nl_app_bar.dart';
import 'package:nltour_traveler/ui/widget/nl_menu_card.dart';

class MessageListPage extends StatefulWidget {
  @override
  MessageListPageState createState() {
    return new MessageListPageState();
  }
}

class MessageListPageState extends State<MessageListPage> {

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

  }
}
