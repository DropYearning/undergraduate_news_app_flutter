import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:async';
import '../Models/News.dart';

// 各个频道的API URL
Map<String, String> channelNameToUrl = {
  'domestic':'http://111.231.57.151:8000/newlist/domestic/?page=1',
  'international':'http://111.231.57.151:8000/newlist/international/?page=1',
  'finance':'http://111.231.57.151:8000/newlist/finance/?page=1',
  'entertainment':'http://111.231.57.151:8000/newlist/entertainment/?page=1',
  'car':'http://111.231.57.151:8000/newlist/car/?page=1',
  'military':'http://111.231.57.151:8000/newlist/military/?page=1',
  'society':'http://111.231.57.151:8000/newlist/society/?page=1',
  'sport':'http://111.231.57.151:8000/newlist/sport/?page=1',
  'edu':'http://111.231.57.151:8000/newlist/edu/?page=1',
  'digit':'http://111.231.57.151:8000/newlist/digit/?page=1',
  'game':'http://111.231.57.151:8000/newlist/game/?page=1',
  'tech':'http://111.231.57.151:8000/newlist/tech/?page=1',
  'internet':'http://111.231.57.151:8000/newlist/internet/?page=1',
  'estate':'http://111.231.57.151:8000/newlist/estate/?page=1',
};


// 新闻频道的列表样式
class ChannelNewsList extends StatefulWidget {

  String channelName;
  //StatelessWidget更复杂, 一旦其中含有参数必须声明key
  ChannelNewsList({Key key, @required this.channelName}) : super(key: key);
  @override
  _ChannelNewsListState createState() => _ChannelNewsListState();
}

class _ChannelNewsListState extends State<ChannelNewsList> with AutomaticKeepAliveClientMixin{
  // 引入AutomaticKeepAliveClientMixin 和 wantKeepAlive是为了防止在切换回已被加载的Tab时界面时组件被重绘的问题
  @protected
  bool get wantKeepAlive => true;
  
  @override
  void initState(){
      super.initState();
      fetchNewsList();
  }

  fetchNewsList() async{
    String newsUrl = channelNameToUrl[widget.channelName];
    final rsp = await Dio().get(newsUrl);
    // 如果请求成功
    if(rsp.statusCode == 200){
      List<News> newslist = rsp.data['results']
          .map<News>( (item) => News.fromJson(item) )
          .toList();
      //print(rsp.data);
      return newslist;
    }else{
      throw Exception('Falied');
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future:fetchNewsList(),
      builder: (BuildContext context, AsyncSnapshot snapshot){
        if (snapshot.connectionState == ConnectionState.waiting){
          return Center(
            child: CircularProgressIndicator() , //未加载完成则转圈等待
            );
        }
        return ListView(
          children: snapshot.data.map<Widget>((item){
            return ListTile(
              title: Text(item.title),
              subtitle:Text(item.source) ,
              leading: CircleAvatar(
                backgroundImage: NetworkImage(item.picurl1),
              ),
            );
          }).toList(),
        );
      }
    );
  }
}