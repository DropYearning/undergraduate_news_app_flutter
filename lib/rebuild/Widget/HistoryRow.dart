
import 'package:flutter/material.dart';
import '../Models/HistoryItem.dart';
import '../Views/NewsDetailPage.dart';

class HistoryRow extends StatefulWidget {
  final HistoryItem historyItem;
  HistoryRow({Key key, @required this.historyItem}) : super(key: key);
  @override
  _HistoryRowState createState() => _HistoryRowState();
}

class _HistoryRowState extends State<HistoryRow> {

  // 格式化时间
  String modifyTime(String input) {
      String date = input.split("T")[0];
      String time = input.split("T")[1];
      String subtime = time.substring(0, 5);
      String outputTime = date + "  " + subtime;
      return outputTime;
  }

  @override
  Widget build(BuildContext context) {
    // return GestureDetector(
    //   onTap: (){
    //     Navigator.of(context).push(MaterialPageRoute(builder: (context) => DetailPage(news_channel: widget.historyItem.news_channel, news_id: widget.historyItem.news_id,)));
    //   },
    //   child: ,
    // );
    return ListTile(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => DetailPage(news_channel: widget.historyItem.news_channel, news_id: widget.historyItem.news_id,)));
      },
      title: Text(widget.historyItem.news_title),
      subtitle:Text("浏览时间: ${modifyTime(widget.historyItem.savetime)}") ,
    );
  }
}