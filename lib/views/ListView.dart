import 'package:flutter/material.dart';
import '../models/news_entity.dart';
import 'DetailView.dart';

// 中央新闻列表类 ListViewDemo
class ListViewDemo extends StatelessWidget {
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
                    new Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(bottom: 1.0),
                        child: new Text(
                          // 插入新闻标题
                          NewsList[index].title,
                          style: new TextStyle(fontSize: 20.0),
                        )),
                    new Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        new Expanded(
                            child: new Container(
                                padding: const EdgeInsets.all(0.0),
                                // child: new SizedBox(
                                //   // 插入新闻图片
                                //   child: new Image.network(
                                //     NewsList[index].picurl1,
                                //     fit: BoxFit.fitWidth,
                                //   ),
                                //   height: 200.0,
                                // )
                                // 以16:9的比例显示图片
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
                            padding: const EdgeInsets.all(5.0),
                            // 插入新闻发布时间
                            child: new Text(
                              "${NewsList[index].source}  ",
                              style: new TextStyle(
                                  fontSize: 16.0, color: Colors.grey),
                            ),
                          ),
                        new Container(
                            padding: const EdgeInsets.all(5.0),
                            // 插入新闻来源
                            child: new Text(
                              "${NewsList[index].pubtime}",
                              style: new TextStyle(
                                  fontSize: 16.0, color: Colors.grey),
                            )),
                        new Container(
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.all(5.0),
                            // 增加一个推荐按钮(菜单?)
                            child: new IconButton(
                              icon: Icon(Icons.more_horiz),
                              tooltip: "单击推荐更多相似新闻",
                              // 推荐按钮点击事件
                              onPressed: (){},
                              color: Colors.grey,
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
