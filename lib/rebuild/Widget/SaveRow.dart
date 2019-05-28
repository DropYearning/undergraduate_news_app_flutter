
import 'package:flutter/material.dart';
import '../Models/SaveItem.dart';
import '../Views/NewsDetailPage.dart';

class SaveRow extends StatefulWidget {
  final SaveItem saveItem;
  SaveRow({Key key, @required this.saveItem}) : super(key: key);
  @override
  _SaveRowState createState() => _SaveRowState();
}

class _SaveRowState extends State<SaveRow> {

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
    return ListTile(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => DetailPage(news_channel: widget.saveItem.news_channel, news_id: widget.saveItem.news_id,)));
      },
      title: Text(widget.saveItem.news_title),
      subtitle:Text("浏览时间: ${modifyTime(widget.saveItem.savetime)}") ,
    );
  }
}