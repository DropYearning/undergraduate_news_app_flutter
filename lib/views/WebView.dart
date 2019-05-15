import 'package:flutter/material.dart';
import '../models/news_entity.dart';
import 'package:flutter_html_textview/flutter_html_textview.dart';
// 在App中打开内置浏览器
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

// 显示管理后台的页面
class WebAdminPage extends StatelessWidget {
  final flutterWebviewPlugin = new FlutterWebviewPlugin();
  @override
  Widget build(BuildContext context) {
    Widget WebScreen = new WebviewScaffold(
            url: "http://111.231.57.151:8000/xadmin/",
            // 自添加带返回操作的appbar
            withZoom: true,
            appBar: new AppBar(
              centerTitle: true,
              title : Text('新闻后台管理系统'),
              leading: Builder(
                builder: (BuildContext context) {
                  return IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      //按钮事件
                    }
                  );
                },
              ),
            )
          );
    return WebScreen;
  }
}

// 显示新闻原网站页面
class WebNewsPage extends StatelessWidget {
  final NewsEntity news; //新闻数据对象

  WebNewsPage({
    this.news,
  });

  @override
  Widget build(BuildContext context) {
    Widget WebScreen = new WebviewScaffold(
              url: news.link,
              appBar: new AppBar(
                centerTitle: true,
                title: new Text("新闻源链接"),
                actions: <Widget>[IconButton(icon: Icon(Icons.share), onPressed: () {},)],
                leading: Builder(
                builder: (BuildContext context) {
                  return IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context),
                  );
                },
              ),
              ),
            );
    return WebScreen;
  }
}
