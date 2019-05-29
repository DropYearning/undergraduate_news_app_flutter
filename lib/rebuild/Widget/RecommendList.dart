// 首页推荐频道专用的列表类
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:async';
import '../Models/News.dart';
import './NewsRow.dart';


class RecommendList extends StatefulWidget {
  @override
  _RecommendListState createState() => _RecommendListState();
}

class _RecommendListState extends State<RecommendList>  with AutomaticKeepAliveClientMixin {
  GlobalKey<EasyRefreshState> _easyRefreshKey = new GlobalKey<EasyRefreshState>();
  GlobalKey<RefreshHeaderState> _headerKey = new GlobalKey<RefreshHeaderState>();
  GlobalKey<RefreshFooterState> _footerKey = new GlobalKey<RefreshFooterState>();

  @override
  bool get wantKeepAlive => true;

  // 初始新闻列表
  List<News> startList = [];

  @override
  void initState(){
      super.initState();
      // 当组件被绘制前执行HTTP请求新闻列表的操作
      fetchStartList();
  }

  // 获取初始新闻列表
  fetchStartList()async{
    String _url = "http://111.231.57.151:8000/rcm4random10/";
    final rsp = await Dio().get(_url);
    List<News> _newslist = rsp.data
      .map<News>( (item) => News.fromJson(item) )
      .toList();
    if (mounted) {
        setState(() {
          startList = _newslist;
        });
      } 
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if(startList.length != 0) {
        return  Center(
          child: new EasyRefresh(
            key: _easyRefreshKey,
            autoLoad: true,
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
                itemCount: startList.length,
                itemBuilder: (BuildContext context,int index){
                  // 根据图片数判断生成哪种新闻行组件
                  if(startList[index].havepic == 0)
                    return NewsRowWithoutPic(newsItem:startList[index]);
                  else{
                    return NewsRowWithPic(newsItem:startList[index]);
                  }
                }
            ),

            // 设置下拉事件
            onRefresh: () async{

            },
            // 推荐频道没有上拉事件
            loadMore: () async {
              
            },
          ),
        );
    }else{
      return Center(child: Text('loading...'),);
    }
  }
}
