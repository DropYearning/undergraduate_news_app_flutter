
import 'package:flutter/material.dart';
import '../Models/SaveItem.dart';
import '../Views/DetailPage.dart';
import 'package:dio/dio.dart';
import 'dart:async';
import '../Util/DataUtils.dart';
import '../Widget/MyToast.dart';


class SaveRow extends StatefulWidget {
  final SaveItem saveItem;
  SaveRow({Key key, @required this.saveItem}) : super(key: key);
  @override
  _SaveRowState createState() => _SaveRowState();
}

class _SaveRowState extends State<SaveRow> {
  bool isClicked = false;
 

  // 格式化时间
  String modifyTime(String input) {
      String date = input.split("T")[0];
      String time = input.split("T")[1];
      String subtime = time.substring(0, 5);
      String outputTime = date + "  " + subtime;
      return outputTime;
  }

  // 用于改变图标
  Icon _changeIcon(){
    if(isClicked == false ){
      return Icon(Icons.favorite);
    }else{
      return Icon(Icons.favorite_border);
    }
  }

  Color _changeColor(){
    if(isClicked == false ){
      return Colors.black;
    }else{
      return Colors.grey;
    }
  }

  // 取消收藏
  cancelSave()async{
    String username = await DataUtils.getUsername();
    String _url = "http://111.231.57.151:8000/save/" + username + "/" + channelNameToEng[widget.saveItem.news_channel] + "/" +widget.saveItem.news_id;
    debugPrint('取消收藏记录: $_url');
    await Dio().delete(_url);
    showToast("取消成功");
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => DetailPage(news_channel: widget.saveItem.news_channel, news_id: widget.saveItem.news_id,)));
      },
      title: Text(widget.saveItem.news_title,style: TextStyle(fontSize: 18,color: _changeColor())),
      subtitle:Text("收藏时间: ${modifyTime(widget.saveItem.savetime)}",style: TextStyle(fontSize: 16,color: _changeColor())) ,
      trailing: new IconButton(
        icon:_changeIcon(), 
        onPressed:()async{
          setState(() {
            isClicked = !isClicked;
          });
          await cancelSave();
        }),
    );
  }
}


// 各个频道对应的英文
Map<String, String> channelNameToEng = {
  '国内': 'domestic',
  '国际': 'international',
  '财经': 'finance',
  '娱乐': 'entertainment',
  '汽车': 'car',
  '军事': 'military',
  '社会': 'society',
  '体育': 'sport',
  '教育': 'edu',
  '数字': 'digit',
  '游戏': 'game',
  '科技': 'tech',
  '互联网': 'internet',
  '房地产': 'estate',
};