import 'package:flutter/material.dart';
import '../models/news_entity.dart';
import 'DetailView.dart';
import 'dart:async';

enum titleColor {
      black,
      grey,
}


// 中央新闻列表类 ListViewDemo
class ListViewDemo extends StatelessWidget {


  Widget _listItemBuilder(BuildContext context, int index) {

    Color _titleColor = Colors.black;

    return GestureDetector(
      onTap: () {
        // 单击进入新闻详情页
        Navigator.of(context).push(        
          MaterialPageRoute(builder: (context) => DetailView(title: '新闻详情', news: NewsList[index]))
        );
        // 实现页面点击后标题变灰的功能
        
      }, 
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
                        padding: const EdgeInsets.only(bottom: 5.0),
                        child: new Text(
                          // 插入新闻标题
                          NewsList[index].title,
                          style: new TextStyle(fontSize: 20.0, color: _titleColor,),
                        )),
                    new Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        new Expanded(
                            child: new Container(
                                padding: const EdgeInsets.all(0.0),
                                child: AspectRatio(
                                  aspectRatio: 16/9,
                                  child: Image.network(NewsList[index].picurl1,fit: BoxFit.cover,),
                                )
                            )
                          )
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
                              "${NewsList[index].source}  ",
                              style: new TextStyle(
                                  fontSize: 16.0, color: Colors.grey),
                            ),
                          ),
                        new Container(
                            padding: const EdgeInsets.all(0.0),
                            // 插入新闻来源
                            child: new Text(
                              "${NewsList[index].pubtime}",
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
                                  onSelected: (value){
                                    print(value);
                                  },
                                  icon: Icon(Icons.more_horiz, color: Colors.grey,),
                                  itemBuilder: (BuildContext context) => [
                                    PopupMenuItem(
                                      value: 'shoucang',
                                      child: Text('添加到我的收藏',),
                                    ),
                                    PopupMenuItem(
                                      value: 'tuijian',
                                      child: Text('推荐更多相似新闻',),
                                    ),
                                  ],
                                ),

                              ],
                            )

                        ),
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

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: NewsList.length,
      itemBuilder: _listItemBuilder,
    );
  }
}



// 中央新闻列表类 ListViewDemo2 
class ListViewDemo2 extends StatelessWidget {
  Widget _listItemBuilder(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        // 单击进入新闻详情页
        // Navigator.pushNamed(context, '/detail');
        Navigator.of(context).push(        
          MaterialPageRoute(builder: (context) => DetailView(title: '新闻详情', news: NewsList[index]))
        );
      }, 
      child: new Card(
        child: new Material(
            child: new InkWell(
              child: new Container(
                padding: const EdgeInsets.all(5.0),
                child: new Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                  //在这里添加部件




                  ],
                ),
              ),
            ),
            color: Colors.transparent),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: NewsList.length,
      itemBuilder: _listItemBuilder,
    );
  }
}
