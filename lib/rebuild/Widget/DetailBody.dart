// 新闻详情页body组件

import 'package:flutter/material.dart';
import 'package:flutter_html_textview/flutter_html_textview.dart';
import '../Models/NewsDetail.dart';
import 'package:dio/dio.dart';
import 'dart:async';

String modifyTime(String input) {
    String date = input.split("T")[0];
    String time = input.split("T")[1];
    String subtime = time.substring(0, 5);
    String outputTime = date + "  " + subtime;
    return outputTime;
  }

// TODO: 如何自定义HTML内容中文字的大小?
// 本来是想用CSS的办法曲线救国的,结果解析器不支持,加上后会出现图片显示错误的问题
String addCSS(String html){
  String fontSize = '20px';

  return "<div style=\"font-size:$fontSize\">" + html + "</div>";
}


Widget buildDetailBody(NewsDetail newsItemWithHTML){
  return SingleChildScrollView(
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
                          newsItemWithHTML.title,
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
                          "来源: " + newsItemWithHTML.source,
                          style: new TextStyle(
                              fontSize: 16.0, color: Colors.grey),
                        ),
                      ),
                      new Container(
                          // 插入新闻发布时间
                          child: new Text(
                            modifyTime(newsItemWithHTML.pubtime),
                            style: new TextStyle(
                                fontSize: 16.0, color: Colors.grey),
                          )
                      ),
                    ],
                  ),
                ),
                Container(
                        alignment: Alignment.centerLeft,
                        //padding: const EdgeInsets.only(bottom: 5.0),
                        padding: const EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
                        child: new Text(
                          // 插入新闻关键词
                          "新闻关键字: "+newsItemWithHTML.keywords,
                          style: new TextStyle(fontSize: 16.0, color: Colors.grey),
                        )
                  ),
                Divider(height: 10.0, indent: 10.0, color: Colors.black54,),
                Container(
                  padding: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0),
                  child: HtmlTextView(data: newsItemWithHTML.html),
                ),
              ],
            ),
          )
        );
}




// 方法二:使用FutureBuilder构建详情页主体
class FutureBodyBuilder extends StatefulWidget {
  final String newsUrl;
  FutureBodyBuilder({Key key, @required this.newsUrl}) : super(key: key);
  @override
  _FutureBodyBuilderState createState() => _FutureBodyBuilderState();
}

class _FutureBodyBuilderState extends State<FutureBodyBuilder> {
 
  
  final baseUrl = "http://111.231.57.151:8000/detail/";
  NewsDetail newsItemWithHTML ;

  @override
  void initState() {
    fetchNewsDetail();
    super.initState();
  }

  fetchNewsDetail() async {
    String detailUrl = widget.newsUrl;
    final rsp = await Dio().get(detailUrl);
    // 如果请求成功
    if (rsp.statusCode == 200) {
      var newsMap = rsp.data[0];
      // serializable成对象
      NewsDetail _newsDetail = new NewsDetail.fromJson(newsMap);
      if (mounted) {
          setState(() {
            newsItemWithHTML = _newsDetail;
          });
      }
    } else {
      throw Exception('Falied');
    }
  }



  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future:fetchNewsDetail(),
      builder: (BuildContext context, AsyncSnapshot snapshot){
        // 如果网络请求未结束显示Loading...
        if (snapshot.connectionState == ConnectionState.waiting){
          return Center(
            child: Text('loading...') ,
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
  '数字': 'digit',
  '游戏': 'game',
  '科技': 'tech',
  '互联网': 'internet',
  '房地产': 'estate',
};