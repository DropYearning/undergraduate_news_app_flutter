import 'package:flutter/material.dart';
import 'model/news.dart';

// 中央新闻列表类
class ListViewDemo extends StatelessWidget {
  Widget _listItemBuilder(BuildContext context, int index){
    return Container(
      margin: EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Image.network(NewsList[index].picurl1),
          SizedBox(height: 16.0),
          Text(
            NewsList[index].title,
            style: Theme.of(context).textTheme.title,
          ),
        ],
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: NewsList.length,
        itemBuilder: _listItemBuilder,
      );
  }
}
