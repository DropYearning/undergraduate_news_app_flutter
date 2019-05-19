import 'package:flutter/material.dart';
import '../Widget/ChannelNewsList.dart';
import '../Widget/ButtomNavigation.dart';


// app首页类
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

// app首页类对应的State类
class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin{
  // SingleTickerProviderStateMixin用来给Tab增加切换动画效果

  // tab的名字
  final List<Tab> _channelTabs = <Tab>[
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
      body: Container(
        child: TabBarView(
          controller: _tabController,
          
          children: <Widget>[
            // 对应14个频道的TabBarView中显示的内容
            ChannelNewsList(channelName: 'domestic',),
            ChannelNewsList(channelName: 'international',),
            ChannelNewsList(channelName: 'finance',),
            ChannelNewsList(channelName: 'entertainment',),
            ChannelNewsList(channelName: 'car',),
            ChannelNewsList(channelName: 'military',),
            ChannelNewsList(channelName: 'society',),
            ChannelNewsList(channelName: 'sport',),
            ChannelNewsList(channelName: 'edu',),
            ChannelNewsList(channelName: 'digit',),
            ChannelNewsList(channelName: 'game',),
            ChannelNewsList(channelName: 'tech',),
            ChannelNewsList(channelName: 'internet',),
            ChannelNewsList(channelName: 'estate',),      
          ],
        ),
      ),
    bottomNavigationBar: MyBottomNavigationBar(),
    );
  }
}



