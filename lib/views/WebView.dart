import 'package:flutter/material.dart';
import '../models/news_entity.dart';
import 'package:flutter_html_textview/flutter_html_textview.dart';
// 在App中打开内置浏览器
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class WebViewPage extends StatelessWidget {
  final NewsEntity news; //新闻数据对象

  WebViewPage({
    this.news,
  });

  @override
  Widget build(BuildContext context) {

    Widget WebScreen = MaterialApp(
      routes: {
        "/": (_) => new WebviewScaffold(
          url: news.link,
          appBar: new AppBar(
            title: new Text("访问源链接"),
          ),
        ),
      },
    );
    return WebScreen;
  }
}