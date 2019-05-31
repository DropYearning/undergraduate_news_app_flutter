// NewsRow.dart 新闻列表中的行组件,显示一条新闻
import 'package:flutter/material.dart';
import '../Models/News.dart';
import '../Views/DetailPage.dart';
import '../Views/ResultPage.dart';
import '../Util/DataUtils.dart';
import 'package:dio/dio.dart';
import 'dart:async';
import 'package:fluttertoast/fluttertoast.dart';
import '../Widget/MyToast.dart';

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
  '数码': 'digit',
  '游戏': 'game',
  '科技': 'tech',
  '互联网': 'internet',
  '房地产': 'estate',
};


// 没有张图片的新闻列表项
class NewsRowWithoutPic extends StatefulWidget {
  final News newsItem;
  NewsRowWithoutPic({Key key, @required this.newsItem}) : super(key: key);

  @override
  _NewsRowWithoutPicState createState() => _NewsRowWithoutPicState();
}

class _NewsRowWithoutPicState extends State<NewsRowWithoutPic> {
  final saveUrl = "http://111.231.57.151:8000/save/";
  final historyUrl = "http://111.231.57.151:8000/history/";
  
  // bool isLogin;
  // String username;
  bool isClicked = false;

  @override
  void initState() {
    // checkLogin();
    super.initState();
  }

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

  // // 检查登录状态
  // checkLogin()async{
  //   String _username = await DataUtils.getUsername();
  //   bool _isLogin = await DataUtils.getIslogin();
  //   if(mounted){
  //     setState(() {
  //       isLogin = _isLogin;
  //       username = _username;
  //     });
  //   }
  // }

  // 添加收藏
  addSave(String username)async{
      String _url = saveUrl + username + "/" + channelNameToEng[widget.newsItem.channelname] + "/" +widget.newsItem.id;
      debugPrint('添加收藏记录: $_url');
      await Dio().post(_url);
  }

  // 添加访问记录
  addHistory()async{
    String _username = await DataUtils.getUsername();
    bool _isLogin = await DataUtils.getIslogin();
    if(_username =="" || _isLogin == null || _isLogin == false){
      //do nothing
    }else{
      String _url = historyUrl + _username + "/" + channelNameToEng [widget.newsItem.channelname] + "/" + widget.newsItem.id;
      debugPrint('添加访问记录: $_url');
      await Dio().post(_url);
    }
  }

  // 根据点击情况改变字体颜色 color: Colors.grey
  Color _changeColor(){
    if(isClicked == false){
      return Colors.black;
    }else{
      return Colors.grey;
    }
  }

  // 设置点击状态
  setClicked(){
    setState(() {
      isClicked = true;
    });
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: ()  {
            setClicked();
            addHistory();
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => DetailPage(news_channel: widget.newsItem.channelname, news_id: widget.newsItem.id,)));
        },//onTap
        child: new Card(
          child: new Material(
              child: new InkWell(
                child: new Container(
                  padding: const EdgeInsets.all(0.0),
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
                              color: _changeColor(),
                            ),
                          )),
                      new Container(
                        padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                        child: Row(
                          // 三个元素在主轴(横轴)上分散排列
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            new Container(
                              padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                              // 插入新闻来源
                              child: new Text(
                                "${widget.newsItem.source}",
                                style: new TextStyle(
                                    fontSize: 16.0, color: Colors.grey),
                              ),
                            ),
                            new Container(
                                padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                                // 插入新闻时间
                                child: new Text(
                                  modifyTime(),
                                  style: new TextStyle(
                                      fontSize: 16.0, color: Colors.grey),
                                )),
                            new Container(
                                alignment: Alignment.centerRight,
                                padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                                // 增加一个弹出式菜单
                                child: Row(
                                  children: <Widget>[
                                    new PopupMenuButton(
                                      //菜单选项点击事件
                                      onSelected: (value) async {
                                        //print("点击了$value选项");
                                        if(value == '1'){
                                          // 添加收藏记录
                                          String _username =await DataUtils.getUsername();
                                          if(_username != ""){
                                            await addSave(_username);
                                            showToast("收藏成功");
                                          }else{
                                            showToast("请先登录");
                                          }
                                        }else if(value == '2'){
                                          // 跳转推荐结果列表
                                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => ResultPage(newsItem: widget.newsItem,)));
                                        }
                                      },
                                      icon: Icon(
                                        Icons.more_horiz,
                                        color: Colors.grey,
                                      ),
                                      itemBuilder: (BuildContext context) => [
                                            PopupMenuItem(
                                              value: '1',
                                              child: Text(
                                                '添加到我的收藏',
                                              ),
                                            ),
                                            PopupMenuItem(
                                              value: '2',
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
                      ), 
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
  
  final saveUrl = "http://111.231.57.151:8000/save/";
  final historyUrl = "http://111.231.57.151:8000/history/";
  // bool isLogin;
  // String username;
  bool isClicked = false;

  @override
  void initState() {
    // checkLogin();
    super.initState();
  }

  // 格式化数据库传来的datetime字符串
  String modifyTime(){
    String inputTime = widget.newsItem.pubtime;
    String date = inputTime.split("T")[0];
    String time = inputTime.split("T")[1];
    String subtime = time.substring(0, 5);
    String outputTime = date + "  " + subtime;
    return outputTime;
  }

  // // 检查登录状态
  // checkLogin()async{
  //   String _username = await DataUtils.getUsername();
  //   bool _isLogin = await DataUtils.getIslogin();
  //   if(mounted){
  //     setState(() {
  //       isLogin = _isLogin;
  //       username = _username;
  //     });
  //   }
  // }

  // 添加访问记录
  addHistory()async{
    String _username = await DataUtils.getUsername();
    bool _isLogin = await DataUtils.getIslogin();
    if(_username =="" || _isLogin == null || _isLogin == false){
      //do nothing
    }else{
      String _url = historyUrl + _username + "/" + channelNameToEng [widget.newsItem.channelname] + "/" + widget.newsItem.id;
      debugPrint('添加访问记录: $_url');
      await Dio().post(_url);
    }
  }

  // 添加收藏
  addSave(String username)async{
      String _url = saveUrl + username + "/" + channelNameToEng[widget.newsItem.channelname] + "/" +widget.newsItem.id;
      debugPrint('添加收藏记录: $_url');
      await Dio().post(_url);
  }


  // 根据点击情况改变字体颜色 color: Colors.grey
  Color _changeColor(){
    if(isClicked == false){
      return Colors.black;
    }else{
      return Colors.grey;
    }
  }

  // 设置点击状态
  setClicked(){
    setState(() {
      isClicked = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          // 单击进入新闻详情页
          setClicked();
          addHistory();
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => DetailPage(news_channel: widget.newsItem.channelname, news_id: widget.newsItem.id,)));
        },//onTap
        child: new Card(
          child: new Material(
              child: new InkWell(
                child: new Container(
                  padding: const EdgeInsets.all(0.0),
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
                              color: _changeColor(),
                            ),
                          )),
                      new Container(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
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
                      ),
                      new Container(
                        padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                        child: new Row(
                           // 三个元素在主轴(横轴)上分散排列
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            new Container(
                              padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                              // 插入新闻来源
                              child: new Text(
                                "${widget.newsItem.source}  ",
                                style: new TextStyle(
                                    fontSize: 16.0, color: Colors.grey),
                              ),
                            ),
                            new Container(
                                padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                                // 插入新闻发布时间
                                child: new Text(
                                  modifyTime(),
                                  style: new TextStyle(
                                      fontSize: 16.0, color: Colors.grey),
                                )),
                            new Container(
                                alignment: Alignment.centerRight,
                                padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                                // 增加一个弹出式菜单
                                child: Row(
                                  children: <Widget>[
                                    new PopupMenuButton(
                                      //
                                      onSelected: (value) async {
                                        //print("点击了$value选项");
                                        if(value == '1'){
                                          // 添加收藏记录
                                          String _username =await DataUtils.getUsername();
                                          if(_username != ""){
                                            await addSave(_username);
                                            showToast("收藏成功");
                                          }else{
                                            showToast("请先登录");
                                          }
                                        }else if(value == '2'){
                                          // 跳转推荐结果列表
                                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => ResultPage(newsItem: widget.newsItem,)));
                                        }
                                      },
                                      icon: Icon(
                                        Icons.more_horiz,
                                        color: Colors.grey,
                                      ),
                                      itemBuilder: (BuildContext context) => [
                                            PopupMenuItem(
                                              value: '1',
                                              child: Text(
                                                '添加到我的收藏',
                                              ),
                                            ),
                                            PopupMenuItem(
                                              value: '2',
                                              child: Text(
                                                '推荐更多相似新闻',
                                              ),
                                            ),
                                          ],
                                    ),
                                ],
                              )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              color: Colors.transparent
            ),
        ),
      );
  }
}