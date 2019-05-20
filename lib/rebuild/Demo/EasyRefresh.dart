import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
    List<String> addStr=["1","2","3","4","5","6","7","8","9","0"];
  List<String> str=["1","2","3","4","5","6","7","8","9","0"];
  GlobalKey<EasyRefreshState> _easyRefreshKey = new GlobalKey<EasyRefreshState>();
  GlobalKey<RefreshHeaderState> _headerKey = new GlobalKey<RefreshHeaderState>();
  GlobalKey<RefreshFooterState> _footerKey = new GlobalKey<RefreshFooterState>();

  @override
  Widget build(BuildContext context) {
    return  Center(
          child: new EasyRefresh(
            key: _easyRefreshKey,
            autoLoad: false,
            behavior: ScrollOverBehavior(),
            refreshHeader: ClassicsHeader(
              key: _headerKey,
              refreshText: "pullToRefresh",
              refreshReadyText: "releaseToRefresh",
              refreshingText: "refreshing" + "...",
              refreshedText:"refreshed",
              moreInfo: "updateAt",
              bgColor: Colors.transparent,
              textColor: Colors.black87,
              moreInfoColor: Colors.black54,
              showMore: true,
            ),
            refreshFooter: ClassicsFooter(
              key: _footerKey,
              loadText: "pushToLoad",
              loadReadyText: "releaseToLoad",
              loadingText:"loading",
              loadedText: "loaded",
              noMoreText: "noMore",
              moreInfo: "updateAt",
              bgColor: Colors.transparent,
              textColor: Colors.black87,
              moreInfoColor: Colors.black54,
              showMore: true,
            ),
            child: new ListView.builder(
              //ListView的Item
                itemCount: str.length,
                itemBuilder: (BuildContext context,int index){
                  return new Container(
                      height: 70.0,
                      child: Card(
                        child: new Center(
                          child: new Text(str[index],style: new TextStyle(fontSize: 18.0),),
                        ),
                      )
                  );
                }
            ),
            onRefresh: () async{
              await new Future.delayed(const Duration(seconds: 1), () {
                setState(() {
                  str.clear();
                  str.addAll(addStr);
                });
              });
            },
            loadMore: () async {
              await new Future.delayed(const Duration(seconds: 1), () {
                if (str.length < 20) {
                  setState(() {
                    str.addAll(addStr);
                  });
                }
              });
            },
          )
    );
  }
}




