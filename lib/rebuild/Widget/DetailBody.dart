// 新闻详情页body组件
import 'package:flutter/material.dart';
import 'package:flutter_html_textview/flutter_html_textview.dart';
import '../Models/NewsDetail.dart';

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