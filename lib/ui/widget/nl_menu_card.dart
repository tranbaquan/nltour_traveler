import 'package:flutter/material.dart';
import 'package:nltour_traveler/supporter/database/database.dart';
import 'package:nltour_traveler/utils/session.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NLMenuCard extends StatefulWidget {
  @override
  _NLMenuCardState createState() {
    return _NLMenuCardState();
  }
}

class _NLMenuCardState extends State<NLMenuCard> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return _buildDrawer(context);
  }

  Drawer _buildDrawer(context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          buildProfileDrawer(context),
          buildBodyDrawer(context),
        ],
      ),
    );
  }

  Widget buildProfileDrawer(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 84,
            width: 84,
            margin: EdgeInsets.only(top: 32),
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
                    child: Image.network(
                      snapshot.data,
                      fit: BoxFit.cover,
                      height: 84,
                      width: 84,
                    ),
                  );
                } else {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(42),
                    child: Image.asset(
                      'assets/images/NLTravel.png',
                      fit: BoxFit.cover,
                      height: 84,
                      width: 84,
                    ),
                  );
                }
              },
              future: SessionSupporter.getUser().then((data) => data.avatar),
            ),
          ),
          FutureBuilder(
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(
                  snapshot.data.firstName,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: 'Normal',
                  ),
                );
              } else {
                return Text(
                  'Loading...',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: 'Normal',
                  ),
                );
              }
            },
            future: SessionSupporter.getUser(),
          ),
          FutureBuilder(
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(
                  snapshot.data,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontFamily: 'Semilight',
                  ),
                );
              } else {
                return Text(
                  'Loading...',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: 'Normal',
                  ),
                );
              }
            },
            future:
                SessionSupporter.getUser().then((data) => data.address.country),
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
    );
  }

  Widget buildBodyDrawer(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: choices.map((option) {
          return Container(
            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    child: Text(
                      option.title,
                      style: TextStyle(
                        color: Color(0x00ff444444),
                        fontFamily: 'Semilight',
                        fontSize: 14,
                      ),
                    ),
                    onTap: () {
                      option.onTap(context);
                    },
                  ),
                ),
                Divider(
                  color: Color(0x00ffcfcfcf),
                  indent: 0,
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class Option {
  final String title;
  final Function onTap;

  Option({this.title, this.onTap});
}

List<Option> choices = <Option>[
  Option(
    title: 'Home',
    onTap: (BuildContext context) {
      Navigator.pushReplacementNamed(context, '/home');
    },
  ),
  Option(
    title: 'Information',
    onTap: (BuildContext context) {
      Navigator.pushNamed(context, '/info');
    },
  ),
  Option(
    title: 'Payment',
    onTap: (BuildContext context) {
      Navigator.pushNamed(context, '/payment');
    },
  ),
  Option(
    title: 'History',
    onTap: (BuildContext context) {
      Navigator.pushNamed(context, '/history');
    },
  ),
  Option(
    title: 'My messages',
    onTap: (BuildContext context) {
      Navigator.pushNamed(context, '/message_list');
    },
  ),
  Option(
    title: 'Privacy Policy',
    onTap: (BuildContext context) {},
  ),
  Option(
    title: 'Sign Out',
    onTap: (BuildContext context) async {
      final prefs = await SharedPreferences.getInstance();
      prefs.clear().then((isCleared) {
        DatabaseProvider.db.deleteAll();
        if (isCleared) {
          Navigator.of(context).pushReplacementNamed('/');
        }
      });
    },
  ),
];



//          Container(
//            child: Row(
//              children: <Widget>[
//                Expanded(
//                  child: GestureDetector(
//                    child: Text(
//                      choices[2].title,
//                      style: TextStyle(
//                        color: Color(0x00ff444444),
//                        fontFamily: 'Semilight',
//                        fontSize: 14,
//                      ),
//                    ),
//                    onTap: () {
//                      onTap(2);
//                    },
//                  ),
//                ),
//                SpeechBubble(
//                  nipLocation: NipLocation.LEFT,
//                  child: Row(
//                    mainAxisSize: MainAxisSize.min,
//                    children: <Widget>[
//                      Text(
//                        "1",
//                        style: TextStyle(
//                          color: Colors.white,
//                          fontSize: 7.0,
//                        ),
//                      ),
//                    ],
//                  ),
//                ),
//              ],
//            ),
//            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
//          ),
//          Divider(
//            color: Color(0x00ffcfcfcf),
//            indent: 0.0,
//          ),