import 'package:flutter/material.dart';

// 应用启动首页
//Stateful widget可以拥有状态，这些状态在widget生命周期中是可以变的
//Stateful widget至少由两个类组成：一个StatefulWidget类 和 一个 State类
//两个类的关系:StatefulWidget类本身是不变的，但是 State类中持有的状态在widget生命周期中可能会发生变化
class NewsHomePage extends StatefulWidget {
  // 下面两行是申明有状态控件参数的固定格式
  NewsHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _NewsHomePageState createState() => _NewsHomePageState();
}

class _NewsHomePageState extends State<NewsHomePage>
    with SingleTickerProviderStateMixin {
  // 引入SingleTickerProviderStateMixin 实现Tab栏切换动态效果

  TabController _tabController; // 需要定义一个Controller
  List tabs = [
    "国内",
    "国际",
    "财经",
    "娱乐",
    "汽车",
    "军事",
    "社会",
    "体育",
    "教育",
    "数码",
    "游戏",
    "科技",
    "互联网",
    "房地产",
  ]; // 显示在tab中的新闻频道列表
  @override
  void initState() {
    super.initState();
    // 创建Controller
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  // 在_State类中实现Build方法绘制界面
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        // 导航栏右侧菜单键
        actions: <Widget>[IconButton(icon: Icon(Icons.share))],
        bottom: TabBar(
            // 设置为被选中标签字体为深黑色
            unselectedLabelColor: Colors.black87,
            controller: _tabController,
            isScrollable: true,
            // tabs: <Widget>[
            //   Tab(text: "国内"),
            //   Tab(text: "国际"),
            //   Tab(text: "财经"),
            // ],
            tabs: tabs.map((e) => Tab(text: e)).toList()),
      ),
      body: new TabBarView(
        controller: _tabController,
        // children: <Widget>[
        //   new Center(child: new Text('国内')),
        //   new Center(child: new Text('国际')),
        //   new Center(child: new Text('财经')),
        // ],
        children: tabs.map((e) {
          //自动创建tabs.length个Container来显示各频道的数据
          return Container(
            alignment: Alignment.center,
            child: Text(e, textScaleFactor: 5),
          );
        }).toList(),
      ),
      drawer: HomePageDrawer(),
      bottomNavigationBar: BottomNavigationBar(
        // 底部导航
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('首页')),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border), title: Text('推荐')),
          BottomNavigationBarItem(icon: Icon(Icons.person), title: Text('用户')),
        ],
      ),
    );
  }
}

// 左侧抽屉菜单类
class HomePageDrawer extends StatelessWidget {
  const HomePageDrawer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
        // 去掉顶部灰色区域
        padding: EdgeInsets.all(0),
        // 所有抽屉中的子组件都定义到这里：
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text('请登录'),
            accountEmail: Text('登陆后将显示用户邮箱'),
            // 用户
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('assets/images/defaultAvatar.jpeg')
            ),
            decoration: BoxDecoration(
                // 设置背景图片
                image: DecorationImage(
                    // 控制图片填充效果
                    fit: BoxFit.fill,
                    // 指定图片地址
                    image: AssetImage('assets/images/AvatarBackground.jpg'))),
          ),
          ListTile(
            leading: Icon(Icons.message, size: 22.0,),
            title: Text('注册登陆', textAlign: TextAlign.left,)
          ),
          ListTile(
            
            title: Text('我的收藏', textAlign: TextAlign.left,)
          ),
          ListTile(

            title: Text('浏览历史', textAlign: TextAlign.left,)
          ),
          ListTile(

            title: Text('用户设置', textAlign: TextAlign.left,)
          ),
      ],
    ));
  }
}
