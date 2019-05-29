// app首页
import 'package:flutter/material.dart';
import '../Widget/ButtomBar.dart';
import '../Widget/Drawer.dart';
import '../Widget/RefreshNewsList.dart';
import '../Widget/RecommendList.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

// app首页类对应的State类
class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin{
  // SingleTickerProviderStateMixin用来给Tab增加切换动画效果


  // tab的名字
  final List<Tab> _channelTabs = <Tab>[
    Tab(text:'推荐'),
    Tab(text:'国内'),
    Tab(text:'国际'),
    Tab(text:'财经'),
    Tab(text:'娱乐'),
    Tab(text:'汽车'),
    Tab(text:'军事'),
    Tab(text:'社会'),
    Tab(text:'体育'),
    Tab(text:'教育'),
    Tab(text:'数码'),
    Tab(text:'游戏'),
    Tab(text:'科技'),
    Tab(text:'互联网'),
    Tab(text:'房地产'),
  ];

  //定义一个_tabController
  TabController _tabController;

  @override
  void initState(){
    super.initState();
    //创建_tabController
    _tabController = TabController(length: _channelTabs.length, vsync: this);
  }

  //当整个页面dispose时，记得把控制器也dispose掉，释放内存
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Newshub Demo'),
        centerTitle: true,
        bottom: TabBar(
              // indicatorPadding: EdgeInsets.only(bottom: 0.0),
              // 设置为被选中标签字体为深黑色
              unselectedLabelColor: Colors.black87,
              isScrollable: true,
              tabs: _channelTabs,
              controller: _tabController,
            ),
      ),
      drawer: MyDrawer(),
      body: TabBarView(
          controller: _tabController, 
          children: <Widget>[
            // 设置特别的推荐频道
            RecommendList(),
            // 下面十四个频道
            RefreshNewsList(channelName: 'domestic',),
            RefreshNewsList(channelName: 'international'),
            RefreshNewsList(channelName: 'finance',),
            RefreshNewsList(channelName: 'entertainment',),
            RefreshNewsList(channelName: 'car',),
            RefreshNewsList(channelName: 'military',),
            RefreshNewsList(channelName: 'society',),
            RefreshNewsList(channelName: 'sport',),
            RefreshNewsList(channelName: 'edu',),
            RefreshNewsList(channelName: 'digit',),
            RefreshNewsList(channelName: 'game',),
            RefreshNewsList(channelName: 'tech',),
            RefreshNewsList(channelName: 'internet',),
            RefreshNewsList(channelName: 'estate',),      
          ],
        ),
    bottomNavigationBar: MyBottomNavigationBar(),
    );
  }
}



