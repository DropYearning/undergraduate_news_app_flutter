// Save 用户收藏页主体body
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:async';
import '../Models/SaveItem.dart';
import '../Util/DataUtils.dart';
import '../Widget/SaveRow.dart';

class SaveBody extends StatefulWidget {
  @override
  _SaveBodyState createState() => _SaveBodyState();
}

class _SaveBodyState extends State<SaveBody> {
  
  List<SaveItem> saveList = [];
  bool flag = false; //标志网络请求是否完成
  String baseUrl = "http://111.231.57.151:8000/savelist/";

  fetchSaveList() async {
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
      List<SaveItem> _saveList = rsp.data
        .map<SaveItem>( (item) => SaveItem.fromJson(item) )
        .toList();
      if(_saveList.length != 0)
      {
        if (mounted) {
          setState(() {
            saveList = _saveList;
          });
        }
      }
    }
  }

  @override
  void initState(){
      super.initState();
      fetchSaveList();
  }
  @override
  Widget build(BuildContext context) {
    if(flag == false){
      return Container(
               child: Center(
                  child: Text('loading...') ,
               ),
              );
    }else if(flag == true && saveList.length ==0){
      return Container(
                child: Center(
                  child: Text('尚无收藏') ,
                ),
              );
    }else{
      return ListView.builder(
        //ListView的Item
        itemCount: saveList.length,
        itemBuilder: (BuildContext context,int index){
            return SaveRow(saveItem:saveList[index]);
        }
      );
    }
  }
}
