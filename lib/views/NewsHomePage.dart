import 'package:flutter/material.dart';
import '../models/news_entity.dart';
import 'ListView.dart';

// 应用启动首页类 NewsHomePage
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

  // Tabs
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
  ]; 

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
      body: ListViewDemo(),
      drawer: HomePageDrawer(),
      // 底部导航
      bottomNavigationBar: HomePageNavigationBar(),
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
        elevation: 16.0,
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
            leading: Icon(Icons.portrait, size: 25.0,),
            title: Text('注册登陆', textAlign: TextAlign.left, style: TextStyle(fontSize: 15.0)),
            onTap: ()=> Navigator.pop(context),
          ),
          ListTile(
            leading: Icon(Icons.favorite, size: 25.0,),
            title: Text('我的收藏', textAlign: TextAlign.left, style: TextStyle(fontSize: 15.0)),
            onTap: ()=> Navigator.pop(context),
          ),
          ListTile(
            leading: Icon(Icons.history, size: 25.0,),
            title: Text('浏览历史', textAlign: TextAlign.left, style: TextStyle(fontSize: 15.0)),
            onTap: ()=> Navigator.pop(context),
          ),
          ListTile(
            leading: Icon(Icons.settings, size: 25.0,),
            title: Text('用户设置', textAlign: TextAlign.left, style: TextStyle(fontSize: 15.0)),
            onTap: ()=> Navigator.pop(context),
          ),
          Divider(),
            ListTile(
            leading: Icon(Icons.add_to_home_screen, size: 25.0,),
            title: Text('后台管理', textAlign: TextAlign.left, style: TextStyle(fontSize: 15.0)),
            onTap: ()=> Navigator.pop(context),
          ),
            ListTile(
            leading: Icon(Icons.cancel, size: 25.0,),
            title: Text('关闭菜单', textAlign: TextAlign.left, style: TextStyle(fontSize: 15.0)),
            onTap: ()=> Navigator.pop(context),
          ),
      ],
    ));
  }
}



// 底部导航栏
class HomePageNavigationBar extends StatefulWidget {

  @override
  _HomePageNavigationBarState createState() => _HomePageNavigationBarState();
}

class _HomePageNavigationBarState extends State<HomePageNavigationBar> {
  
  int _currentIndex = 0;
  void _onTapHandler(int index){
    setState(() {
      _currentIndex = index ;
    });
  }
 
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: _onTapHandler,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('首页')),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border), title: Text('推荐')),
          BottomNavigationBarItem(icon: Icon(Icons.person), title: Text('用户')),
        ],
      );
  }
}