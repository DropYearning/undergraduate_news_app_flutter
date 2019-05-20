import 'package:flutter/material.dart';
import '../Widget/ChannelNewsList.dart';

// NewsColumn组件,包含顶部切换频道的Tabbar以及显示新闻列表的ListView
class NewsColumn extends StatefulWidget {
  @override
  _NewsColumnState createState() => _NewsColumnState();
}

class _NewsColumnState extends State<NewsColumn> with SingleTickerProviderStateMixin{
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
    _tabController = TabController(length: _channelTabs.length,vsync: this);
  }

  //当整个页面dispose时，记得把控制器也dispose掉，释放内存
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TabBar(
              // indicatorPadding: EdgeInsets.only(bottom: 0.0),
              // 设置为被选中标签字体为深黑色
              unselectedLabelColor: Colors.black87,
              isScrollable: true,
              tabs: _channelTabs,
              controller: _tabController,
            ),
      Container(),


      ],
    );
  }
}