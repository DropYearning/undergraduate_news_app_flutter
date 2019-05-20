import 'package:flutter/material.dart';
// 此包用与在App中打开内置浏览器
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';



// 显示管理后台的页面
class XadminPage extends StatelessWidget {
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
                      Navigator.pop(context);
                    }
                  );
                },
              ),
            )
          );
    return WebScreen;
  }
}