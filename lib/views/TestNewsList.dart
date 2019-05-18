import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert'; //用来处理json
import '../models/news.dart';

class TestNewsListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('测试'),
        elevation: 0.0,
      ),
      body:HttpDemoHome(),
    );
  }
}

class HttpDemoHome extends StatefulWidget {
  @override
  _HttpDemoHomeState createState() => _HttpDemoHomeState();
}

class _HttpDemoHomeState extends State<HttpDemoHome> {
  @override
    void initState(){
      super.initState();
      fetchNews();
      //   .then((value) => print(value));
    }

  fetchNews() async{
    final rsp = await Dio().get('http://111.231.57.151:8000/newlist/domestic/?page=1');
    // 如果请求成功
    if(rsp.statusCode == 200){
      List<News> newslist = rsp.data['results']
          .map<News>( (item) => News.fromJson(item) )
          .toList();
      return newslist;
    }else{
      throw Exception('Falied');
    }
  }


  
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future:fetchNews(),
      builder: (BuildContext context, AsyncSnapshot snapshot){

        if (snapshot.connectionState == ConnectionState.waiting){
          return Center(
            child: Text('load...') ,
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