import 'package:flutter/material.dart';
import '../models/news_entity.dart';
import '../models/news.dart';
import 'DetailView.dart';
import 'dart:async';

class SliverListDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverList(
        delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
      return GestureDetector(
        onTap: () {
          // 单击进入新闻详情页
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  DetailView( news: newsList[index])));
          // 实现页面点击后标题变灰的功能
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
                          padding: const EdgeInsets.only(bottom: 0.0),
                          child: new Text(
                            // 插入新闻标题
                            newsList[index].title,
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
                                  padding: const EdgeInsets.all(0.0),
                                  child: AspectRatio(
                                    aspectRatio: 16 / 9,
                                    child: Image.network(
                                      newsList[index].picurl1,
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
                            // 插入新闻发布时间
                            child: new Text(
                              "${newsList[index].source}  ",
                              style: new TextStyle(
                                  fontSize: 16.0, color: Colors.grey),
                            ),
                          ),
                          new Container(
                              padding: const EdgeInsets.all(0.0),
                              // 插入新闻来源
                              child: new Text(
                                "${newsList[index].pubtime}",
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
    }));
  }
}
