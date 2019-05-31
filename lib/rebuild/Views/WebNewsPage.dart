import 'package:flutter/material.dart';
// 在App中打开内置浏览器
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';


// 显示新闻原网站页面
class WebNewsVisit extends StatefulWidget {
  final String link;
  WebNewsVisit({Key key, @required this.link}) : super(key: key);
  @override
  _WebNewsVisitState createState() => _WebNewsVisitState();
}

class _WebNewsVisitState extends State<WebNewsVisit> {
  final flutterWebviewPlugin = new FlutterWebviewPlugin();
  
  @override
  Widget build(BuildContext context) {
    Widget webScreen = new WebviewScaffold(
              withZoom: true,
              url: widget.link,
              appBar: new AppBar(
                centerTitle: true,
                title: new Text("新闻源链接"),
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
    return webScreen;
  }
}

// TODO: 修复iOS系统不能打开源链接网页的问题
class SourcePage extends StatelessWidget {
  final String link;
  SourcePage({Key key, @required this.link}) : super(key: key);

   @override
  Widget build(BuildContext context) {
    Widget webScreen = new WebviewScaffold(
            url: link,
            // 自添加带返回操作的appbar
            withZoom: true,
            appBar: new AppBar(
              centerTitle: true,
              title : Text('新闻源链接'),
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
    return webScreen;
  }
}