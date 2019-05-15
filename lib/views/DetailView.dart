import 'package:flutter/material.dart';
// flutter_html_textview包解析html标签转换成flutter控件展示
import 'package:flutter_html_textview/flutter_html_textview.dart';
//import 'package:flutter_html_view/flutter_html_view.dart';
import '../models/news_entity.dart';
import './WebView.dart';


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
          child:Container(
            padding: const EdgeInsets.all(10.0),
            child:Column(
              children: <Widget>[
                 Container(
                        alignment: Alignment.centerLeft,
                        //padding: const EdgeInsets.only(bottom: 5.0),
                        padding: const EdgeInsets.fromLTRB(5.0, 10.0, 10.0, 10.0),
                        child: new Text(
                          // 插入新闻标题
                          news.title,
                          style: new TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
                        )
                  ),
                Container(
                  padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Container(
                        // 插入新闻来源
                        child: new Text(
                          "来源: " + news.source,
                          style: new TextStyle(
                              fontSize: 16.0, color: Colors.grey),
                        ),
                      ),
                      new Container(
                          // 插入新闻发布时间
                          child: new Text(
                            news.pubtime,
                            style: new TextStyle(
                                fontSize: 16.0, color: Colors.grey),
                          )
                      ),
                    ],
                  ),
                ),
                Divider(height: 10.0, indent: 10.0, color: Colors.black54,),
                Container(
                  padding: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0),
                  child: HtmlTextView(data: news.html),
                ),
                //最好增加一个竖排的按钮组, 一个用于返回,一个用于访问原链接          
              ],
            ),
          ) 
        ),
      // 添加浮动返回按钮
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.open_in_new),
        onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => WebNewsPage(news: this.news)));
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}