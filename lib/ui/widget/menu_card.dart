import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MenuCard extends StatefulWidget {
  @override
  _MenuCardState createState() {
    return new _MenuCardState();
  }
}

class _MenuCardState extends State<MenuCard> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: MediaQuery
          .of(context)
          .size
          .height,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          buildHeader(context),
          buildOption(context),
        ],
      ),
    );
  }

  Widget buildHeader(BuildContext context) {
    var header = UserAccountsDrawerHeader(
      accountEmail: Text('tranbaquan.tbq@gmail.com'),
      accountName: Text('Trần Bá Quan'),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF008fe5), Color(0xFF3eb43e)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey[500],
            offset: Offset(0.0, 1.5),
            blurRadius: 1.5,
          ),
        ],
      ),
      currentAccountPicture: CircleAvatar(
        backgroundColor: Colors.green,
      ),
    );

    var widget1 = Container(
      padding: EdgeInsets.all(16),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              Icons.brightness_1,
              size: 120,
              color: Colors.greenAccent,
            ),
            Text('Piper CJ'),
            Text('Minisapolis'),
          ],
        ),
      ),
    );
    var widget2 = Container(
      padding: EdgeInsets.symmetric(horizontal: 32),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('17'),
              Text('TRIPS'),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('17'),
              Text('TRIPS'),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('12'),
              Text('LOCATION'),
            ],
          ),
        ],
      ),
    );

    var widget3 = Container(
      child: Column(
        children: <Widget>[
          widget1,
          widget2,
        ],
      ),
    );
    var card = Container(
      padding: EdgeInsets.all(16),
      width: MediaQuery
          .of(context)
          .size
          .width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF008fe5), Color(0xFF3eb43e)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey[500],
            offset: Offset(0.0, 1.5),
            blurRadius: 1.5,
          ),
        ],
      ),
      child: Stack(
        children: <Widget>[
          widget3,
          IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: () {})
        ],
      ),
    );
    return card;
  }

  Widget buildOption(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: choices.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(choices[index].title),
            onTap: () {
              onTap(index);
            },
          );
        },
      ),
    );
  }

  onTap(int index) {
    List<ChoiceEvent> events = <ChoiceEvent>[
      ChoiceEvent(onTap: (BuildContext context) {}),
      ChoiceEvent(onTap: (BuildContext context) {}),
      ChoiceEvent(onTap: (BuildContext context) {}),
      ChoiceEvent(onTap: (BuildContext context) {}),
      ChoiceEvent(onTap: (BuildContext context) {}),
      ChoiceEvent(onTap: (BuildContext context) async {
        final prefs = await SharedPreferences.getInstance();
        prefs.setBool('logged', false).then((isCleared) {
          if (isCleared) {
            Navigator.of(context).pushReplacementNamed('/');
          }
        });
      }),
    ];
    events[index].onTap(context);
  }
}

class Choice {
  final String title;

  const Choice({this.title});
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'Update Information'),
  const Choice(title: 'Tour is waiting'),
  const Choice(title: 'Payment'),
  const Choice(title: 'View History'),
  const Choice(title: 'Privacy Policy | Term of Use'),
  const Choice(title: 'Sign Out'),
];

class ChoiceEvent {
  Function onTap;

  ChoiceEvent({this.onTap});
}
