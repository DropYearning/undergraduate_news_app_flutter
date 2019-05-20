import 'package:flutter/material.dart';
import '../Views/XadminPage.dart';
import '../Views/LoginPage.dart';


// 首页左侧抽屉菜单部件
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
            //onTap: ()=> Navigator.of(context).pushNamed("/reg"),
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginPage()));
            },
          ),
          ListTile(
            leading: Icon(Icons.star, size: 25.0,),
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
            // onTap: ()=> Navigator.of(context).pushNamed("/xadmin"),
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => XadminPage()));
            },
          ),
            ListTile(
            leading: Icon(Icons.adb, size: 25.0,),
            title: Text('测试页面', textAlign: TextAlign.left, style: TextStyle(fontSize: 15.0)),
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => XadminPage()));
            },
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


