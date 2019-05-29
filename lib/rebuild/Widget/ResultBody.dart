// ResultBody 推荐结果页面主体body
import 'package:flutter/material.dart';
import 'dart:async';
import '../Models/News.dart';
import '../Widget/ResultRow.dart';

class ResultBody extends StatefulWidget {
  List<News> resultList;
  News newsItem;
  ResultBody({Key key, @required this.resultList,  @required this.newsItem}) : super(key: key);
  @override
  _ResultBodyState createState() => _ResultBodyState();
}

class _ResultBodyState extends State<ResultBody> {
  @override
  Widget build(BuildContext context) {
    if(widget.resultList.length == 0){
       return Container(
               child: Center(
                  child: Text('暂无推荐结果...') ,
               ),
        );
    }else{
      return SingleChildScrollView(
        child:Container(
          child:Column(
            children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
                //padding: const EdgeInsets.only(bottom: 5.0),
                padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 0.0),
                child: new Text(
                  // 插入新闻标题
                  "与[${widget.newsItem.title}]相似的结果如下:",
                  style: new TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
                )
              ),
              Container(
                alignment: Alignment.centerLeft,
                //padding: const EdgeInsets.only(bottom: 5.0),
                padding: const EdgeInsets.fromLTRB(15.0, 10.0, 0.0, 0.0),
                child: new Text(
                  // 插入原新闻关键词
                  "原新闻关键字: "+ widget.newsItem.keywords,
                  style: new TextStyle(fontSize: 16.0, color: Colors.black54),
                )
              ),
              Divider(height: 10.0, indent: 10.0, color: Colors.black54,),
              //插入推荐结果新闻列表
              ListView.builder(
                        //ListView的Item
                        shrinkWrap: true,
                        itemCount: widget.resultList.length,
                        itemBuilder: (BuildContext context,int index){
                            return ResultRow(newsItem: widget.resultList[index]);
                        }
              ),
            ],
          ),
        ),
      );
    }
  }
}


ListView buildMyList(List<News> _resultList){
  return ListView.builder(
    //ListView的Item
    shrinkWrap: true,
    itemCount: _resultList.length,
    itemBuilder: (BuildContext context,int index){
        return ResultRow(newsItem: _resultList[index]);
    }
  );
} 

