import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:async';
import '../Models/NewsDetail.dart';
import '../Models/News.dart';
import '../Widget/BuildDetailBody.dart';
import '../Views/WebNewsPage.dart';

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

class NewsDetailPage extends StatefulWidget {
  final News newsItem;
  NewsDetailPage({Key key, @required this.newsItem}) : super(key: key);
  @override
  _NewsDetailPageState createState() => _NewsDetailPageState();
}

class _NewsDetailPageState extends State<NewsDetailPage> {
  // 一个请求例子(http://111.231.57.151:8000/detail/edu/ee5299b03326c1f816031f912dae31d7)
  final baseUrl = "http://111.231.57.151:8000/detail/";

  NewsDetail newsItemWithHTML = new NewsDetail();

  @override
  void initState() {
     fetchNewsDetail();
    super.initState();
  }

  fetchNewsDetail() async {
    String detailUrl = baseUrl +
        channelNameToEng[widget.newsItem.channelname] +
        "/" +
        widget.newsItem.id;
    final rsp = await Dio().get(detailUrl);
    // 如果请求成功
    if (rsp.statusCode == 200) {
      var newsMap = rsp.data[0];
      // serializable成对象
      NewsDetail _newsDetail = new NewsDetail.fromJson(newsMap);
      // _newsDetail;
      if (mounted) {
          setState(() {
            newsItemWithHTML = _newsDetail;
          });
      }
    } else {
      throw Exception('Falied');
    }
  }

  // 格式化数据库传来的datetime字符串
  String modifyTime() {
    String inputTime = widget.newsItem.pubtime;
    String date = inputTime.split("T")[0];
    String time = inputTime.split("T")[1];
    String subtime = time.substring(0, 5);
    String outputTime = date + "  " + subtime;
    return outputTime;
  }

  @override
  Widget build(BuildContext context) {
    if (newsItemWithHTML.title == null) {
      return Scaffold(
        appBar: AppBar(
        title: Text('新闻详情'),
        // TODO: 完成分享新闻详情按钮
        actions: <Widget>[IconButton(icon: Icon(Icons.share), onPressed: () {  },)],
        elevation: 0.0,
        centerTitle: true,
        ),
        body: Center(
            child: Text('load...') ,
            ),
      );
    } else {
      return Scaffold(
      appBar: AppBar(
        title: Text('新闻详情'),
        // TODO: 完成分享新闻详情按钮
        actions: <Widget>[IconButton(icon: Icon(Icons.share), onPressed: () {  },)],
        elevation: 0.0,
        centerTitle: true,
      ),
      body:buildDetailBody(newsItemWithHTML),
      //添加浮动按钮
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.open_in_new),
        onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => WebNewsVisit(link:widget.newsItem.link)));
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }



    //  return Scaffold(
    //   appBar: AppBar(
    //     title: Text('新闻详情'),
    //     // TODO: 完成分享新闻详情按钮
    //     actions: <Widget>[IconButton(icon: Icon(Icons.share), onPressed: () {  },)],
    //     elevation: 0.0,
    //     centerTitle: true,
    //   ),
    //   body:buildDetailBody(newsItemWithHTML),
    //   //添加浮动按钮
    //   floatingActionButton: FloatingActionButton(
    //     child: Icon(Icons.open_in_new),
    //     onPressed: (){
    //       Navigator.of(context).push(MaterialPageRoute(builder: (context) => WebNewsVisit(link:widget.newsItem.link)));
    //     },
    //   ),
    //   floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    // );


  }
}



