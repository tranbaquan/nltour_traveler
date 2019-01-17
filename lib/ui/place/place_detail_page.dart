import 'package:flutter/material.dart';
import 'package:nltour_traveler/model/tour/place.dart';
import 'package:nltour_traveler/ui/widget/nl_app_bar.dart';
import 'package:nltour_traveler/ui/widget/nl_card.dart';

class PlaceDetailPage extends StatelessWidget {
  final Place place;

  PlaceDetailPage({Key key, this.place}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NLAppbar.buildAppbar(context, place.name),
      body: buildContent(context),
    );
  }

  buildContent(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: <Widget>[
            Image.network(
              place.imageUrl,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey[500],
                      offset: Offset(0, 1.5),
                      blurRadius: 1.5)
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {},
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(bottom: 5),
                          child: Icon(
                            Icons.flag,
                            color: Color(0xFF008fe5),
                          ),
                        ),
                        Text(
                          'DISCOVER',
                          style: TextStyle(
                            color: Color(0xFF008fe5),
                            fontSize: 14,
                            fontFamily: 'Semilight',
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(bottom: 5),
                          child: Icon(
                            Icons.place,
                            color: Color(0xFF008fe5),
                          ),
                        ),
                        Text(
                          'MAPS',
                          style: TextStyle(
                            color: Color(0xFF008fe5),
                            fontSize: 14,
                            fontFamily: 'Semilight',
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(bottom: 5),
                          child: Icon(
                            Icons.favorite_border,
                            color: Color(0xFF008fe5),
                          ),
                        ),
                        Text(
                          'FAVORITES',
                          style: TextStyle(
                            color: Color(0xFF008fe5),
                            fontSize: 14,
                            fontFamily: 'Semilight',
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(bottom: 5),
                          child: Icon(
                            Icons.book,
                            color: Color(0xFF008fe5),
                          ),
                        ),
                        Text(
                          'BOOK',
                          style: TextStyle(
                            color: Color(0xFF008fe5),
                            fontSize: 14,
                            fontFamily: 'Semilight',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(16),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(right: 5),
                        child: Text(
                          place.name,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.yellow,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.yellow,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.yellow,
                      ),
                    ],
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(bottom: 10),
                    child: Text(
                      place.address.address,
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 12,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                  Text(
                    place.description,
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: NLFormCard(
                place: this.place,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
