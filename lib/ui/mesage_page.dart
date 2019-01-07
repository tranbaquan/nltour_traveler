import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nltour_traveler/ui/widget/nl_app_bar.dart';

class MessagePage extends StatefulWidget {
  @override
  MessagePageState createState() {
    return MessagePageState();
  }
}

List<String> messages = [
  'abwwwwwc',
  'def',
  'abc',
  'dewwwwwwwwwwf',
  'defwwwwwwwwwwwwww',
  'def',
  'def',
  'wwwwwwwww',
  'def',
  'def',
  'dewwwwwwwwwf',
  'desf',
  'dwwwwwwwwwwwef',
  'deaassf',
  'def',
  'dessssf',
  'dsssssssssssssef',
  'dddef',
  'deeeeeeeeef',
  'dessssssf',
  'abwwwwwwwwc',
  'dwwef',
  'abc',
  'def'
];

class MessagePageState extends State<MessagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NLAppBar.buildAppBar(context),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                  reverse: true,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    return Row(
                      children: <Widget>[
                        index % 2 == 0
                            ? Expanded(
                                child: Container(),
                              )
                            : Container(
                                margin: EdgeInsets.symmetric(vertical: 2),
                                padding: EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Color(0xff008fe5),
                                ),
                                child: Text(
                                  messages[index],
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Normal',
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                        index % 2 == 0
                            ? Container(
                                margin: EdgeInsets.symmetric(vertical: 2),
                                padding: EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Color(0xff008fe5),
                                ),
                                child: Text(
                                  messages[index],
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Normal',
                                    fontSize: 14,
                                  ),
                                ),
                              )
                            : Expanded(
                                child: Container(),
                              )
                      ],
                    );
                  },
                ),
              ),
              Divider(
                height: 1,
              ),
              Container(
                decoration: BoxDecoration(color: Theme.of(context).cardColor),
                child: _buildTextComposer(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSendButton() {
    return IconButton(
      onPressed: () {},
      icon: Icon(Icons.send),
    );
  }

  Widget _buildTextComposer() {
    return IconTheme(
        data: IconThemeData(color: Theme.of(context).accentColor),
        child: Container(
          margin: EdgeInsets.all(0),
          child: Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(0),
                child: IconButton(
                  icon: Icon(Icons.camera_alt),
                  onPressed: () {},
                ),
              ),
              Flexible(
                child: TextFormField(
                  maxLengthEnforced: true,
                  decoration: InputDecoration(
                    hintText: 'Send a message',
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 4.0),
                child: buildSendButton(),
              ),
            ],
          ),
        ));
  }
}
