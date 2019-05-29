// ResultRow 结果页面列表中的一行
import 'package:flutter/material.dart';
import '../Models/News.dart';
import '../Views/DetailPage.dart';


class ResultRow extends StatefulWidget {
  final News newsItem;
  ResultRow({Key key, @required this.newsItem}) : super(key: key);
  @override
  _ResultRowState createState() => _ResultRowState();
}


class _ResultRowState extends State<ResultRow> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => DetailPage(news_channel: widget.newsItem.channelname, news_id: widget.newsItem.id,)));
      },
      title: Text(widget.newsItem.title,style: TextStyle(fontSize: 18),),
      subtitle:Text("关键词: ${widget.newsItem.keywords}", style: TextStyle(fontSize: 16)) ,
    );
  }

}

