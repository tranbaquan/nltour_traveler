import 'package:flutter/material.dart';
import 'package:nltour_traveler/model/tour/tour.dart';
import 'package:nltour_traveler/ui/widget/nl_app_bar.dart';

class HistoryDetailPage extends StatelessWidget {
  final Tour tour;

  const HistoryDetailPage({Key key, this.tour}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NLAppbar.buildAppbar(context, 'Tour Detail'),
      body: buildContent(context),
    );
  }

  buildContent(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: <Widget>[
            Stack(
              alignment: AlignmentDirectional(0, 1),
              children: <Widget>[
                Image.network(
                  tour.place.imageUrl,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),
                Container(
                  padding: EdgeInsets.all(16),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    tour.place.name,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.all(16),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 100,
                    alignment: Alignment.centerLeft,
                    child: Text('Place:'),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Text(tour.place.name),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
