import 'package:flutter/material.dart';
// flutter_html_textview包解析html标签转换成flutter控件展示
import 'package:flutter_html_textview/flutter_html_textview.dart';
import '../models/news_entity.dart';


class DetailView extends StatelessWidget {

  
  final String title; //appbar标题
  final NewsEntity news; //新闻数据对象

  DetailView({
    this.title,
    this.news,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        elevation: 0.0,
      ),
        body: new SingleChildScrollView(
          child: new Center(
            child: new HtmlTextView(data: news.html),
          ),
        ),
      // 添加浮动返回按钮
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_back),
        onPressed: (){
          Navigator.pop(context);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}