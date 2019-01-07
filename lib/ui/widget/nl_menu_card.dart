import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speech_bubble/speech_bubble.dart';

class NLMenuCard extends StatefulWidget {
  @override
  _NLMenuCardState createState() {
    return new _NLMenuCardState();
  }
}

class _NLMenuCardState extends State<NLMenuCard> {

  @override
  Widget build(BuildContext context) {
    return _buildProfileDrawer(context);
  }

  onTap(int index) {
    List<ChoiceEvent> events = <ChoiceEvent>[
      ChoiceEvent(onTap: (BuildContext context) {
        Navigator.of(context).pushReplacementNamed('/home');
      }),
      ChoiceEvent(onTap: (BuildContext context) {
        Navigator.of(context).pushNamed('/info');
      }),
      ChoiceEvent(onTap: (BuildContext context) {
        Navigator.of(context).pushNamed('/payment');
      }),
      ChoiceEvent(onTap: (BuildContext context) {
        Navigator.of(context).pushNamed('/history');
      }),
      ChoiceEvent(onTap: (BuildContext context) {}),
      ChoiceEvent(onTap: (BuildContext context) async {
        final prefs = await SharedPreferences.getInstance();
        prefs.clear().then((isCleared) {
          if (isCleared) {
            Navigator.of(context).pushReplacementNamed('/');
          }
        });
      }),
    ];
    events[index].onTap(context);
  }

  Future<String> getInfo(String type) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(type);
  }

  Drawer _buildProfileDrawer(context) {
    return new Drawer(
      child: new ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            decoration: new BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0x00ff008fe5),
                    Color(0x00ff3eb43e),
                  ],
                  begin: FractionalOffset.topLeft,
                  end: FractionalOffset.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey[500],
                      offset: Offset(0, 1.5),
                      blurRadius: 1.5)
                ]),
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 84,
                  width: 84,
                  margin: EdgeInsets.symmetric(horizontal: 0, vertical: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(42),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x80000000),
                        blurRadius: 4.0,
                      ),
                    ],
                  ),
                  child: FutureBuilder(
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(42),
                          child: new Image.network(
                            snapshot.data,
                            fit: BoxFit.cover,
                            height: 84,
                            width: 84,
                          ),
                        );
                      } else {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(42),
                          child: new Image.network(
                            'https://firebasestorage.googleapis.com/v0/b/nltour-2018.appspot.com/o/travel.jpg?alt=media&token=1effd6f7-0ac3-4b68-b758-48c4bcf71465',
                            fit: BoxFit.cover,
                            height: 84,
                            width: 84,
                          ),
                        );
                      }
                    },
                    future: getInfo('avatar'),
                  ),
                ),
                FutureBuilder(
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Text(
                        snapshot.data,
                        style: new TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: 'Normal',
                        ),
                      );
                    } else {
                      return Text(
                        'Loading...',
                        style: new TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: 'Normal',
                        ),
                      );
                    }
                  },
                  future: getInfo('firstName'),
                ),
                new Text(
                  'Ho Chi Minh City',
                  style: new TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontFamily: 'Semilight',
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 18, horizontal: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Text(
                            '17',
                            style: TextStyle(
                                fontFamily: 'Semilight',
                                fontSize: 20,
                                color: Colors.white),
                          ),
                          Text(
                            'TRIPS',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontFamily: 'Semilight',
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Text(
                            '2',
                            style: TextStyle(
                                fontFamily: 'Semilight',
                                fontSize: 20,
                                color: Colors.white),
                          ),
                          Text(
                            'PENDING TOURS',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontFamily: 'Semilight',
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Text(
                            '9',
                            style: TextStyle(
                                fontFamily: 'Semilight',
                                fontSize: 20,
                                color: Colors.white),
                          ),
                          Text(
                            'RATING',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontFamily: 'Semilight',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: GestureDetector(
                    child: Text(
                      'Home',
                      style: TextStyle(
                        color: Color(0x00ff444444),
                        fontFamily: 'Semilight',
                        fontSize: 14,
                      ),
                    ),
                    onTap: () {
                      onTap(0);
                    },
                  ),
                  margin: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
                ),
                new Divider(
                  color: Color(0x00ffcfcfcf),
                  indent: 0.0,
                ),
                Container(
                  child: GestureDetector(
                    child: Text(
                      'Update information',
                      style: TextStyle(
                        color: Color(0x00ff444444),
                        fontFamily: 'Semilight',
                        fontSize: 14,
                      ),
                    ),
                    onTap: () {
                      onTap(1);
                    },
                  ),
                  margin: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
                ),
                new Divider(
                  color: Color(0x00ffcfcfcf),
                  indent: 0.0,
                ),
                Container(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: GestureDetector(
                          child: Text(
                            'Payment',
                            style: TextStyle(
                              color: Color(0x00ff444444),
                              fontFamily: 'Semilight',
                              fontSize: 14,
                            ),
                          ),
                          onTap: () {
                            onTap(2);
                          },
                        ),
                      ),
                      SpeechBubble(
                        nipLocation: NipLocation.LEFT,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              "1",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 7.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  margin: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
                ),
                new Divider(
                  color: Color(0x00ffcfcfcf),
                  indent: 0.0,
                ),
                Container(
                  child: GestureDetector(
                    child: Text(
                      'View history',
                      style: TextStyle(
                        color: Color(0x00ff444444),
                        fontFamily: 'Semilight',
                        fontSize: 14,
                      ),
                    ),
                    onTap: () {
                      onTap(3);
                    },
                  ),
                  margin: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
                ),
                new Divider(
                  color: Color(0x00ffcfcfcf),
                  indent: 0.0,
                ),
                Container(
                  child: GestureDetector(
                    child: Text(
                      'Privacy Policy | Term of Use',
                      style: TextStyle(
                        color: Color(0x00ff444444),
                        fontFamily: 'Semilight',
                        fontSize: 14,
                      ),
                    ),
                    onTap: () {
                      onTap(4);
                    },
                  ),
                  margin: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
                ),
                new Divider(
                  color: Color(0x00ffcfcfcf),
                  indent: 0.0,
                ),
                Container(
                  child: GestureDetector(
                    child: Text(
                      'Sign out',
                      style: TextStyle(
                        color: Color(0x00ff444444),
                        fontFamily: 'Semilight',
                        fontSize: 14,
                      ),
                    ),
                    onTap: () {
                      onTap(5);
                    },
                  ),
                  margin: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Choice {
  final String title;

  const Choice({this.title});
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'Home'),
  const Choice(title: 'Update information'),
  const Choice(title: 'Payment'),
  const Choice(title: 'View history'),
  const Choice(title: 'Privacy Policy | Term of Use'),
  const Choice(title: 'Sign Out'),
];

class ChoiceEvent {
  Function onTap;

  ChoiceEvent({this.onTap});
}
