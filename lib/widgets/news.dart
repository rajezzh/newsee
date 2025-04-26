import 'package:flutter/material.dart';
import 'package:newsee/AppData/newscollections.dart';

/* 

widget that takes list of news object and renders in list 

user can edit by adding a tags and mark as favourite

 */
class NewsCard extends StatefulWidget {
  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<StatefulWidget> {
  /* 
    the actual implementatio of the News widget 
   */
  var newsList = news_collections;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: renderNewsCard(),
    );
  }

  List<Widget> renderNewsCard() {
    List<Widget> widgets = [];
    for (int i = 0; i < 10; i++) {
      widgets.add(
        Column(
          children: [
            DecoratedBox(
              key: Key(news_collections[i].id),
              decoration: BoxDecoration(
                color: Colors.amber[300],
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                border: Border.all(width: 1.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(news_collections[i].heading),
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      );
    }
    return widgets;
  }
}
