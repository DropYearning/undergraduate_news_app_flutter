// HistoryBody 用户历史页主体body
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:async';
import '../Models/HistoryItem.dart';
import '../Util/DataUtils.dart';
import '../Widget/HistoryRow.dart';

class HistoryBody extends StatefulWidget {
  @override
  _HistoryBodyState createState() => _HistoryBodyState();
}

class _HistoryBodyState extends State<HistoryBody> {
  
  List<HistoryItem> historyList = [];
  bool flag = false; //标志网络请求是否完成
  String baseUrl = "http://111.231.57.151:8000/historylist/";

  fetchHistoryList() async {
    String __username = await DataUtils.getUsername();
    if(__username != ""){
      print(__username);
      String userUrl = baseUrl + __username;
      final rsp = await Dio().get(userUrl);
      if (mounted) {
        setState(() {
          flag = true;
        });
      }
      List<HistoryItem> _historyList = rsp.data
        .map<HistoryItem>( (item) => HistoryItem.fromJson(item) )
        .toList();
      if(_historyList.length != 0)
      {
        if (mounted) {
          setState(() {
            historyList = _historyList;
          });
        }
      }
    }
  }

  @override
  void initState(){
      super.initState();
      fetchHistoryList();
  }
  @override
  Widget build(BuildContext context) {
    if(flag == false){
      return Container(
               child: Center(
                  child: Text('loading...') ,
               ),
              );
    }else if(flag == true && historyList.length ==0){
      return Container(
                child: Center(
                  child: Text('尚无历史记录') ,
                ),
              );
    }else{
      return ListView.builder(
        //ListView的Item
        itemCount: historyList.length,
        itemBuilder: (BuildContext context,int index){
            return HistoryRow(historyItem:historyList[index]);
        }
      );
    }
  }
}
