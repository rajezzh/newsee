import 'package:flutter/material.dart';
import 'package:newsee/AppData/newscollections.dart';

class NewsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: renderNews());
  }

  List<Widget> renderNews() {
    List<Widget> newsCard = [];
    news_collections.forEach((news) {
      newsCard.add(Text(key: Key(news.id), news.heading));
    });
    return newsCard;
  }
}
