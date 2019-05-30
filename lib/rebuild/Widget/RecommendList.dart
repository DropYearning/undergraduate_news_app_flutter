// 首页推荐频道专用的列表类
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:async';
import '../Models/News.dart';
import './NewsRow.dart';
import '../Widget/MyToast.dart';


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
  List<News> newsList = [];
  // 下拉更新新增的列表 
  List<News> updateList = [];
  // 用来代替原来新闻列表的列表
  List<News> newsListNew = [];

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
          newsList = _newslist;
        });
      } 
  }

  // 获取下拉推荐
  fetchRcmList() async{
    String _rcmUrl = "http://111.231.57.151:8000/rcm4random3/";
    final rsp = await Dio().get(_rcmUrl);
     List<News> _rcmList = rsp.data
          .map<News>( (item) => News.fromJson(item) )
          .toList();
    // 先清空之前的更新列表
    setState(() {
      updateList.clear();
      newsListNew.clear();
      //将当前的newsList赋值给NewsListNew
      newsListNew.addAll(newsList);
    });
    // 倒序插入 _rcmList(请求到的推荐列表)到newsListNew中
    for(int i=_rcmList.length-1;i>=0;i--)
      {
        setState(() {
          updateList.add(_rcmList[i]);
          newsListNew.insert(0, _rcmList[i]);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if(newsList.length != 0) {
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
              loadText: "该频道已到底",
              loadReadyText: "释放",
              loadingText:"该频道已到底",
              loadedText: "该频道已到底",
              noMoreText: "该频道已到底",
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
              await fetchRcmList();
              int updateCount = updateList.length;
              await new Future.delayed(const Duration(seconds: 1), () {
                if(updateCount !=0 ){
                  //如果有更新
                  setState(() {
                    newsList.clear();
                    newsList.addAll(newsListNew);
                  });
                  showToast('已为您推荐${updateCount}条新闻');
                }else{
                  //如果没有更新
                  showToast('暂时没有更多哦');
                }
              });
            },
            // 推荐频道没有上拉事件
            loadMore: () async {
              // do nothing
            },
          ),
        );
    }else{
      return Center(child: Text('loading...'),);
    }
  }
}
