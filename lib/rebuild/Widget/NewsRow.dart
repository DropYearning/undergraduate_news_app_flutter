import 'package:flutter/material.dart';
import '../Models/News.dart';
import '../Views/NewsDetailPage.dart';


// 没有张图片的新闻列表项
class NewsRowWithoutPic extends StatefulWidget {
  final News newsItem;
  NewsRowWithoutPic({Key key, @required this.newsItem}) : super(key: key);

  @override
  _NewsRowWithoutPicState createState() => _NewsRowWithoutPicState();
}

class _NewsRowWithoutPicState extends State<NewsRowWithoutPic> {

  // 格式化数据库传来的datetime字符串
  String modifyTime(){
    String inputTime = widget.newsItem.pubtime;
    String date = inputTime.split("T")[0];
    String time = inputTime.split("T")[1];
    String subtime = time.substring(0, 5);
    String outputTime = date + "  " + subtime;
    return outputTime;
  }

  // 合并来源和时间生成新闻下方的副标题
  String getSubtitle(){
    String inputTime = widget.newsItem.pubtime;
    String date = inputTime.split("T")[0];
    String time = inputTime.split("T")[1];
    String subtime = time.substring(0, 5);
    String outputTime = date + "  " + subtime;
    return widget.newsItem.source+ "    " +outputTime;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          // 点击进入新闻详情页
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => NewsDetailPage(newsItem:widget.newsItem)));
        },//onTap
        child: new Card(
          child: new Material(
              child: new InkWell(
                child: new Container(
                  padding: const EdgeInsets.all(5.0),
                  child: new Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      new Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                          child: new Text(
                            // 插入新闻标题
                            widget.newsItem.title,
                            style: new TextStyle(
                              fontSize: 20.0,
                              color: Colors.black,
                            ),
                          )),
                      new Row(
                        // 三个元素在主轴(横轴)上分散排列
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          new Container(
                            padding: const EdgeInsets.all(0.0),
                            // 插入新闻来源
                            child: new Text(
                              "${widget.newsItem.source}",
                              style: new TextStyle(
                                  fontSize: 16.0, color: Colors.grey),
                            ),
                          ),
                          new Container(
                              padding: const EdgeInsets.all(0.0),
                              // 插入新闻时间
                              child: new Text(
                                modifyTime(),
                                style: new TextStyle(
                                    fontSize: 16.0, color: Colors.grey),
                              )),
                          new Container(
                              alignment: Alignment.centerRight,
                              padding: const EdgeInsets.all(0.0),
                              // 增加一个弹出式菜单
                              child: Row(
                                children: <Widget>[
                                  new PopupMenuButton(
                                    //
                                    onSelected: (value) {
                                      print(value);
                                    },
                                    icon: Icon(
                                      Icons.more_horiz,
                                      color: Colors.grey,
                                    ),
                                    itemBuilder: (BuildContext context) => [
                                          PopupMenuItem(
                                            value: 'shoucang',
                                            child: Text(
                                              '添加到我的收藏',
                                            ),
                                          ),
                                          PopupMenuItem(
                                            value: 'tuijian',
                                            child: Text(
                                              '推荐更多相似新闻',
                                            ),
                                          ),
                                        ],
                                  ),
                                ],
                              )),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              color: Colors.transparent),
        ),
      );
  }
}


// 至少有一张图片的新闻列表页部件
class NewsRowWithPic extends StatefulWidget {
  final News newsItem;
  NewsRowWithPic({Key key, @required this.newsItem}) : super(key: key);
  @override
  _NewsRowWithPicState createState() => _NewsRowWithPicState();
}

class _NewsRowWithPicState extends State<NewsRowWithPic> {

  // 格式化数据库传来的datetime字符串
  String modifyTime(){
    String inputTime = widget.newsItem.pubtime;
    String date = inputTime.split("T")[0];
    String time = inputTime.split("T")[1];
    String subtime = time.substring(0, 5);
    String outputTime = date + "  " + subtime;
    return outputTime;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          // 单击进入新闻详情页
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => NewsDetailPage(newsItem:widget.newsItem)));
        },//onTap
        child: new Card(
          child: new Material(
              child: new InkWell(
                child: new Container(
                  padding: const EdgeInsets.all(5.0),
                  child: new Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      new Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                          child: new Text(
                            // 插入新闻标题
                            widget.newsItem.title,
                            style: new TextStyle(
                              fontSize: 20.0,
                              color: Colors.black,
                            ),
                          )),
                      new Row(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          new Expanded(
                              child: new Container(
                                  padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                                  child: AspectRatio(
                                    aspectRatio: 16 / 9,
                                    child: Image.network(
                                      widget.newsItem.picurl1,
                                      fit: BoxFit.cover,
                                    ),
                                  )))
                        ],
                      ),
                      new Row(
                        // 三个元素在主轴(横轴)上分散排列
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          new Container(
                            padding: const EdgeInsets.all(0.0),
                            // 插入新闻来源
                            child: new Text(
                              "${widget.newsItem.source}  ",
                              style: new TextStyle(
                                  fontSize: 16.0, color: Colors.grey),
                            ),
                          ),
                          new Container(
                              padding: const EdgeInsets.all(0.0),
                              // 插入新闻发布时间
                              child: new Text(
                                modifyTime(),
                                style: new TextStyle(
                                    fontSize: 16.0, color: Colors.grey),
                              )),
                          new Container(
                              alignment: Alignment.centerRight,
                              padding: const EdgeInsets.all(0.0),
                              // 增加一个弹出式菜单
                              child: Row(
                                children: <Widget>[
                                  new PopupMenuButton(
                                    //
                                    onSelected: (value) {
                                      print(value);
                                    },
                                    icon: Icon(
                                      Icons.more_horiz,
                                      color: Colors.grey,
                                    ),
                                    itemBuilder: (BuildContext context) => [
                                          PopupMenuItem(
                                            value: 'shoucang',
                                            child: Text(
                                              '添加到我的收藏',
                                            ),
                                          ),
                                          PopupMenuItem(
                                            value: 'tuijian',
                                            child: Text(
                                              '推荐更多相似新闻',
                                            ),
                                          ),
                                        ],
                                  ),
                                ],
                              )),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              color: Colors.transparent),
        ),
      );
  }
}