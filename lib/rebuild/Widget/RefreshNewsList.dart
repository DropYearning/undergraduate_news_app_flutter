// RefreshNewsList 可上拉更新和下拉加载的新闻列表,使用了easy_refresh插件

import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:async';
import '../Models/News.dart';
import './NewsRow.dart';



class RefreshNewsList extends StatefulWidget {

  final String channelName;
  //StatelessWidget更复杂, 一旦其中含有参数必须声明key
  RefreshNewsList({Key key, @required this.channelName}) : super(key: key);
  @override
  _RefreshNewsListState createState() => _RefreshNewsListState();
}

class _RefreshNewsListState extends State<RefreshNewsList> {
  GlobalKey<EasyRefreshState> _easyRefreshKey = new GlobalKey<EasyRefreshState>();
  GlobalKey<RefreshHeaderState> _headerKey = new GlobalKey<RefreshHeaderState>();
  GlobalKey<RefreshFooterState> _footerKey = new GlobalKey<RefreshFooterState>();

  // 当前所有新闻的列表
  List<News> newsList = [];
  // idSet保存当前newsList中所有新闻的id
  Set<String> idSet = new Set<String>() ;
  // 上拉刷新要添加在下方的List
  List<News> moreList = [];
  // 下拉刷新请求结果中新的新闻保存在这个列表中
  List<News> updateList = [];
  // 用来更新替换旧的newsList的List
  List<News> newsListNew = [];
  // 上拉加载到的新闻页数,一开始为1
  int morePageIndex = 1;



  @override
  void initState(){
      super.initState();
      // 当组件被绘制前执行HTTP请求新闻列表的操作
      fetchNewsList();
  }

  // 启动时加载新闻列表
  fetchNewsList() async{
    String newsUrl = channelNameToUrl[widget.channelName]+"1";
    final rsp = await Dio().get(newsUrl);
    // 如果请求成功
    if(rsp.statusCode == 200){
      List<News> _newslist = rsp.data['results']
          .map<News>( (item) => News.fromJson(item) )
          .toList();

      // 设置State类内的参数必须使用setState
      for(int i=0;i<_newslist.length;i++)
      {
        // 在setState前判断一下是否在Widget树中,防止setState() called after dispose()错误
        if (mounted) {
          setState(() {
          idSet.add(_newslist[i].id);
          }); 
        }
      }
      if (mounted) {
          setState(() {
            newsList = _newslist;
          });
      } 
    // // 调试输出
    // print("fetchNewsList当前Set中新闻个数为"+idSet.length.toString());
    // printList(newsList);
    }else{
      throw Exception('Falied');
    }
  }

  // 上拉加载更多
  fetchMoreList() async{
    String newsUrl = channelNameToUrl[widget.channelName]
    + morePageIndex.toString();
    final rsp = await Dio().get(newsUrl);
    // 如果请求成功
    if(rsp.statusCode == 200){
      List<News> _newslist = rsp.data['results']
          .map<News>( (item) => News.fromJson(item) )
          .toList();
      // 设置State类内的参数必须使用setState
      setState(() {
        moreList.clear();
        moreList = _newslist;
      });
    }else{
      throw Exception('Falied');
    }
  }

  // 下拉更新
  fetchUpdateList() async{
    String newsUrl = channelNameToUrl[widget.channelName]
    +"1";
    final rsp = await Dio().get(newsUrl);
    // 如果请求成功
    if(rsp.statusCode == 200){
      List<News> _newslist = rsp.data['results']
          .map<News>( (item) => News.fromJson(item) )
          .toList();
      
      // 先清空之前的更新列表
      setState(() {
        updateList.clear();
        newsListNew.clear();
        //将当前的newsList赋值给NewsListNew
        newsListNew.addAll(newsList);
      });

      for(int i=_newslist.length-1;i>=0;i--)
      {
          //如果这条新闻之前没有
          if(idSet.contains(_newslist[i].id) == false)
          {
            setState(() {
              idSet.add(_newslist[i].id);
              updateList.add(_newslist[i]);
              newsListNew.insert(0, _newslist[i]);
            });
          }
      }
      // // 调试输出
      // print("[fetchUpdateList]函数:当前Set中新闻个数为"+idSet.length.toString());
      // print("[fetchUpdateList]函数:本次updateList为:");
      // printList(updateList);  
    }else{
      throw Exception('Falied');
    }
  }



  // 打印输出List,调试用
  printList(List<News> l){
    String s = "";
    for(int i=0;i<l.length;i++)
    {
        s = s + ", " +l[i].title;
    }
    print(s);
  }


  // 返回构建
  @override
  Widget build(BuildContext context) {
    if(newsList.length != 0) {
        return  Center(
          child: new EasyRefresh(
            key: _easyRefreshKey,
            autoLoad: false,
            //firstRefresh: true,
            behavior: ScrollOverBehavior(),
            // 下拉样式设置
            refreshHeader: ClassicsHeader(
              key: _headerKey,
              refreshText: "向下滑动更新列表",
              refreshReadyText: "释放",
              refreshingText: "正在加载...",
              refreshedText:"加载成功",
              //moreInfo: "updateAt",
              bgColor: Colors.transparent,
              textColor: Colors.black87,
              moreInfoColor: Colors.black54,
              showMore: true,
            ),
            // 上拉样式设置
            refreshFooter: ClassicsFooter(
              key: _footerKey,
              loadText: "向上滑动加载更多",
              loadReadyText: "释放",
              loadingText:"正在加载...",
              loadedText: "加载成功",
              noMoreText: "noMore",
              //moreInfo: "updateAt",
              bgColor: Colors.transparent,
              textColor: Colors.black87,
              moreInfoColor: Colors.black54,
              showMore: true,
            ),
            child: new ListView.builder(
              //ListView的Item
                itemCount: newsList.length,
                itemBuilder: (BuildContext context,int index){
                  // 根据图片数判断生成哪种新闻行组件
                  if(newsList[index].havepic == 0)
                    return NewsRowWithoutPic(newsItem:newsList[index]);
                  else{
                    return NewsRowWithPic(newsItem:newsList[index]);
                  }
                }
            ),

            // 设置下拉事件
            onRefresh: () async{
              // 一定要使用await先执行更新,否则会出现异步错误
              await fetchUpdateList();
              // // 调试输出
              // print("[onRefresh函数]:输出下拉之前的newsList");
              // printList(newsList);
              // print("[onRefresh函数]:输出更新之后的newsListNew");
              // printList(newsListNew);
              int updateCount = updateList.length;
              await new Future.delayed(const Duration(seconds: 1), () {
                if(updateCount !=0 ){
                  //如果有更新
                  setState(() {
                    newsList.clear();
                    newsList.addAll(newsListNew);
                  });
                }else{
                  //如果没有更新
                }
              });
              String toastMsg = "";
              if (updateCount != 0) {
                toastMsg = "已为您更新$updateCount条新闻";
              } else {
                toastMsg = "暂无更新";
              }
              // 弹出toast
              Fluttertoast.showToast(
                  msg: toastMsg,
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIos: 1,
                  backgroundColor: Colors.black54,
                  textColor: Colors.white,
                  fontSize: 16.0
              );
            },
            // 设置上拉事件
            loadMore: () async {
              setState(() {
                morePageIndex = morePageIndex+1;
              });
              await fetchMoreList();
              // // 调试输出
              // print("当前下拉到的页数为:"+morePageIndex.toString());
              // printList(moreList);
              await new Future.delayed(const Duration(seconds: 1), () {
                setState(() {
                  newsList.addAll(moreList);
                });
              });
            },
          ),
        );
    }else{
      return Center(child: Text('loading...'),);
    }
  }
}


// 各个频道的API URL
Map<String, String> channelNameToUrl = {
  'domestic':'http://111.231.57.151:8000/newlist/domestic/?page=',
  'international':'http://111.231.57.151:8000/newlist/international/?page=',
  'finance':'http://111.231.57.151:8000/newlist/finance/?page=',
  'entertainment':'http://111.231.57.151:8000/newlist/entertainment/?page=',
  'car':'http://111.231.57.151:8000/newlist/car/?page=',
  'military':'http://111.231.57.151:8000/newlist/military/?page=',
  'society':'http://111.231.57.151:8000/newlist/society/?page=',
  'sport':'http://111.231.57.151:8000/newlist/sport/?page=',
  'edu':'http://111.231.57.151:8000/newlist/edu/?page=',
  'digit':'http://111.231.57.151:8000/newlist/digit/?page=',
  'game':'http://111.231.57.151:8000/newlist/game/?page=',
  'tech':'http://111.231.57.151:8000/newlist/tech/?page=',
  'internet':'http://111.231.57.151:8000/newlist/internet/?page=',
  'estate':'http://111.231.57.151:8000/newlist/estate/?page=',
};
