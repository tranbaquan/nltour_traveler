import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nltour_traveler/model/collaborator/collaborator.dart';
import 'package:nltour_traveler/model/traveler/traveler.dart';
import 'package:nltour_traveler/ui/widget/nl_app_bar.dart';

class MessagePage extends StatefulWidget {
  final Collaborator collaborator;
  final Traveler traveler;

  const MessagePage({Key key, this.collaborator, this.traveler})
      : super(key: key);

  @override
  MessagePageState createState() {
    return MessagePageState();
  }
}

class MessagePageState extends State<MessagePage> {
  CollectionReference messageReference;
  CollectionReference messageReference1;
  final _message = TextEditingController();

  @override
  void initState() {
    super.initState();
    messageReference = Firestore.instance.collection('message/' +
        widget.traveler.personalID +
        '/' +
        widget.collaborator.personalID);

  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NLAppbar.buildAppbar(context, 'Message'),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: <Widget>[
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: messageReference.snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError)
                      return new Text('Error: ${snapshot.error}');
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return Center(child: CircularProgressIndicator());
                      default:
                        return Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          child: new ListView(
                            reverse: true,
                            children: snapshot.data.documents
                                .map((DocumentSnapshot document) {
                                  return Row(
                                    children: <Widget>[
                                      document['email'] == widget.traveler.email
                                          ? Expanded(
                                              child: Container(),
                                            )
                                          : Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  child: Image.network(
                                                    widget.collaborator.avatar,
                                                    height: 40,
                                                    width: 40,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.all(2),
                                                  padding: EdgeInsets.all(10),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    color: Color(0xff008fe5),
                                                  ),
                                                  child: Text(
                                                    document['content'],
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontFamily: 'Normal',
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                      document['email'] == widget.traveler.email
                                          ? Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                Container(
                                                  margin: EdgeInsets.all(2),
                                                  padding: EdgeInsets.all(10),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    color: Color(0xff008fe5),
                                                  ),
                                                  child: Text(
                                                    document['content'],
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontFamily: 'Normal',
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ),
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  child: Image.network(
                                                    widget.traveler.avatar,
                                                    height: 40,
                                                    width: 40,
                                                    fit: BoxFit.cover,
                                                  ),
                                                )
                                              ],
                                            )
                                          : Expanded(
                                              child: Container(),
                                            )
                                    ],
                                  );
                                })
                                .toList()
                                .reversed
                                .toList(),
                          ),
                        );
                    }
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
      onPressed: () {
        sendMessage();
      },
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
                  controller: _message,
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

  void sendMessage() {
    messageReference
        .add({'email': widget.traveler.email, 'content': _message.text});
    setState(() {
      _message.clear();
    });
  }
}
