// HistoryPage 用户历史页
import 'package:flutter/material.dart';
import '../Widget/HistoryBody.dart';
import 'package:dio/dio.dart';
import 'dart:async';
import '../Util/DataUtils.dart';
import '../Widget/MyToast.dart';


class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  bool clickClear = false;

  // 弹出确认对话框
  _showMyDialog(){
    showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          title: Text('清除所有记录'),
          content: Text('点击确定将清除该用户所有浏览记录'),
          actions: <Widget>[
            FlatButton(
              child: Text("取消"),
              onPressed: (){
                Navigator.pop(context);
              },
            ),
            FlatButton(
              child: Text("确定"),
              onPressed: (){
                clearHistory();
                Navigator.pop(context);
              },
            ),
          ],
        );
      }
    );
  }

  // 清除该用户的所有记录
  clearHistory()async{
    String _username =await DataUtils.getUsername();
    if(_username == ""){
      showToast('请先登录');
    }else{
      String _url = "http://111.231.57.151:8000/history/" + _username + '/' + "clear/all";
      await Dio().delete(_url);
      showToast('清除成功');
      // 重绘背景组件
      setState(() {
        clickClear = true;
      }); 
    }
  }

  @override
  Widget build(BuildContext context) {
    if(clickClear == false){
      return Scaffold(
      appBar: AppBar(
        title: Text('浏览历史'),
        centerTitle: true,
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete), onPressed: () {
                  // 删除所有历史记录的按钮
                    _showMyDialog();
                  },
          )
        ],
      ),
      body: HistoryBody(),
      );
    }else{
      return Scaffold(
        appBar: AppBar(
          title: Text('浏览历史'),
          centerTitle: true,
          elevation: 0.0,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.delete), onPressed: () {
                    // 删除所有历史记录的按钮
                      _showMyDialog();
                    },
            )
          ],
        ),
        body: Container(
                child: Center(child: Text('尚无历史记录')),
              ),
      );
    }
  }
}


