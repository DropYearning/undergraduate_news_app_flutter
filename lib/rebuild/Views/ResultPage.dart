// 按新闻ID推荐的结果页面
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:async';
import '../Util/DataUtils.dart';
import '../Widget/MyToast.dart';
import '../Widget/ResultBody.dart';
import '../Models/News.dart';

class ResultPage extends StatefulWidget {
  final News newsItem;
  ResultPage({Key key, @required this.newsItem}) : super(key: key);
  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  List<News> resultList =[];

  // 请求推荐结果
  fetchResultList()async{
    String _url = "http://111.231.57.151:8000/rcm4news/" + channelNameToEng[widget.newsItem.channelname]+ "/" + widget.newsItem.id;
    final rsp = await Dio().get(_url);
    //print(rsp.data);
    List<News> _newsList = rsp.data
        .map<News>( (item) => News.fromJson(item) )
        .toList();
    if(mounted){
      setState(() {
        resultList = _newsList;
      });
    }
  }

  @override
  void initState(){
    fetchResultList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('相似新闻'),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: ResultBody(resultList: resultList,newsItem: widget.newsItem,),
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
  '数码': 'digit',
  '游戏': 'game',
  '科技': 'tech',
  '互联网': 'internet',
  '房地产': 'estate',
};