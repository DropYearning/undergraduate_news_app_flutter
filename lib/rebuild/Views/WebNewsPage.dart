import 'package:flutter/material.dart';
import '../models/NewsDetail.dart';
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