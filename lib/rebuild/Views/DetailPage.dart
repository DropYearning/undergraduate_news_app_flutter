/*
 * @Author: Brightzh 
 * @Date: 2019-05-30 22:32:13 
 * @Last Modified by:   Brightzh 
 * @Last Modified time: 2019-05-30 22:32:13 
 */

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:async';
import '../Models/NewsDetail.dart';
import '../Widget/DetailBody.dart';
import '../Views/WebNewsPage.dart';
import '../Util/DataUtils.dart';
import '../Widget/MyToast.dart';

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

class DetailPage extends StatefulWidget {
  final String news_id;
  final String news_channel;
  DetailPage({Key key, @required this.news_id, @required this.news_channel}) : super(key: key);
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  // 一个请求例子(http://111.231.57.151:8000/detail/edu/ee5299b03326c1f816031f912dae31d7)
  final baseUrl = "http://111.231.57.151:8000/detail/";
  final historyUrl = "http://111.231.57.151:8000/history/";
  NewsDetail newsItemWithHTML = new NewsDetail();
  bool isSaved = false;
  bool isLogin;
  String username;

  // 用于改变图标
  Icon _changeIcon(){
    if(isSaved == false ){
      return Icon(Icons.turned_in_not);
    }else{
      return Icon(Icons.turned_in);
    }
  }

  @override
  void initState() {
    checkLogin();
    fetchNewsDetail();
    super.initState();
  }

  // 检查登录状态, 同时检查收藏状态
  checkLogin()async{
    String _username = await DataUtils.getUsername();
    bool _isLogin = await DataUtils.getIslogin();
    if(mounted){
      setState(() {
        isLogin = _isLogin;
        username = _username;
      });
    }
    // 检查收藏状态
    if(_username !="" && _isLogin == true ){
       String _url = "http://111.231.57.151:8000/checksave/" + username + "/" + widget.news_id;
       final rsp = await Dio().get(_url);
       if(rsp.data['code'] == '888'){
          if(mounted){
            setState(() {
              isSaved = true;
            });
          }
       }else if(rsp.data['code'] == '889'){
          if(mounted){
            setState(() {
              isSaved = false;
            });
          }
       }
    }
  }

  // // 添加访问记录
  // addHistory()async{
  //   if(username =="" || isLogin == null || isLogin == false){
  //     //do nothing
  //   }else{
  //     String _url = historyUrl + username + "/" + channelNameToEng [widget.news_channel] + "/" + widget.news_id;
  //     debugPrint('添加访问记录: $_url');
  //     await Dio().post(_url);
  //   }
  // }

  // 添加收藏
  addSave() async{
    // 仅当有用户登录时添加记录
    if(username =="" || isLogin == null || isLogin == false){
      showToast("请先登录");
    }else{
        String _url = "http://111.231.57.151:8000/save/" + username + "/" + channelNameToEng[widget.news_channel] + "/" + widget.news_id;
        debugPrint('添加收藏记录: $_url');
        await Dio().post(_url);
        setState(() {
          isSaved = true;
        });
        showToast("收藏成功");
    }
  }

  // 取消收藏
  cancelSave() async{
    String _url = "http://111.231.57.151:8000/save/" + username + "/" + channelNameToEng[widget.news_channel] + "/" + widget.news_id;
        debugPrint('取消收藏记录: $_url');
        await Dio().delete(_url);
        setState(() {
          isSaved = false;
        });
        showToast("取消成功");
  }

  // 请求新闻详情
  fetchNewsDetail() async {
    String detailUrl = baseUrl +
        channelNameToEng[widget.news_channel] +
        "/" +
        widget.news_id;
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
    String inputTime = newsItemWithHTML.pubtime;
    String date = inputTime.split("T")[0];
    String time = inputTime.split("T")[1];
    String subtime = time.substring(0, 5);
    String outputTime = date + "  " + subtime;
    return outputTime;
  }

  @override
  Widget build(BuildContext context) {
    // 下面的这个if/else判断十分重要, 因为DIO请求newsItemWithHTML是异步进行的,Setstate方法会使组件被重绘
    // 因此在绘制buildDetailBody组件之前,必须保证newsItemWithHTML中已经得到了要请求的数据,否则会出现called on null
    // 错误
    if (newsItemWithHTML.title == null) {
      return Scaffold(
        appBar: AppBar(
        title: Text('新闻详情'),
        actions: <Widget>[IconButton(icon: _changeIcon(), onPressed: () async{  
          if(isSaved == false){
            await addSave();
          }else{
            await cancelSave();
          }
        },)],
        elevation: 0.0,
        centerTitle: true,
        ),
        body: Center(
            child: Text('loading...') ,
            ),
      );
    } else {
      return Scaffold(
      appBar: AppBar(
        title: Text('新闻详情'),
        // TODO: 完成分享新闻详情按钮
        actions: <Widget>[IconButton(icon: _changeIcon(), onPressed: () async{ 
          if(isSaved == false){
            await addSave();
          }else{
            await cancelSave();
          }
        },)],
        elevation: 0.0,
        centerTitle: true,
      ),
      body:buildDetailBody(newsItemWithHTML),
      //添加浮动按钮
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.open_in_new),
        onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => WebNewsVisit(link:newsItemWithHTML.link)));
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

}
}



