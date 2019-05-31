// 首页左侧抽屉菜单部件
import 'package:flutter/material.dart';
import '../Views/XadminPage.dart';
import '../Views/LoginPage.dart';
import '../Views/HistoryPage.dart';
import '../Views/SavePage.dart';
import '../Views/UserPage.dart';
import '../Util/DataUtils.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:async';


class MyDrawer extends StatefulWidget {
  @override
  _MyDrawerState createState() => _MyDrawerState();
}



class _MyDrawerState extends State<MyDrawer> {

  bool _isLogin;
  String _username;


  setDrawerStatus()async{
    String __username = await DataUtils.getUsername();
    bool __isLogin = await DataUtils.getIslogin();
    setState(() {
      _isLogin = __isLogin;
      _username = __username;
    });
  }

  @override
  void initState(){
      super.initState();
      setDrawerStatus();
  }

  @override
  Widget build(BuildContext context) {
    // 如果当前没有用户登录
    if(_isLogin==null || _isLogin==false){
        return Drawer(
          elevation: 16.0,
          child: ListView(
          // 去掉顶部灰色区域
          padding: EdgeInsets.all(0),
          // 所有抽屉中的子组件都定义到这里：
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text('请登录'),
              accountEmail: Text('登陆后将用户名'),
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
            Divider(), 
            ListTile(
              leading: Icon(Icons.settings, size: 25.0,),
              title: Text('软件设置', textAlign: TextAlign.left, style: TextStyle(fontSize: 15.0)),
              //onTap: ()=> Navigator.pop(context),SettingPage
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => SettingPage()));
              },
            ),
            ListTile(
              leading: Icon(Icons.add_to_home_screen, size: 25.0,),
              title: Text('后台管理', textAlign: TextAlign.left, style: TextStyle(fontSize: 15.0)),
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => XadminPage()));
              },
            ),
            ListTile(
              leading: Icon(Icons.adb, size: 25.0,),
              title: Text('测试按钮', textAlign: TextAlign.left, style: TextStyle(fontSize: 15.0)),
              onTap: ()async {
                // Navigator.of(context).push(MaterialPageRoute(builder: (context) => XadminPage());
                  String _username = await DataUtils.getUsername();
                  bool _isLogin = await DataUtils.getIslogin();
                  debugPrint('当前登录的用户名为:$_username, $_isLogin');
              },
            ),
            ListTile(
              leading: Icon(Icons.cancel, size: 25.0,),
              title: Text('关闭菜单', textAlign: TextAlign.left, style: TextStyle(fontSize: 15.0)),
              onTap: ()=> Navigator.pop(context),
            ),
        ],
        )
      );
    } else{
      // 登录状态下
      return Drawer(
        elevation: 16.0,
        child: ListView(
        // 去掉顶部灰色区域
        padding: EdgeInsets.all(0),
        // 所有抽屉中的子组件都定义到这里：
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text('欢迎您'),
            accountEmail: Text('$_username'),
            // 用户
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('assets/images/LoginAvatar.jpeg')
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
            leading: Icon(Icons.star, size: 25.0,),
            title: Text('我的收藏', textAlign: TextAlign.left, style: TextStyle(fontSize: 15.0)),
            onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => SavaPage()));
            },    
          ),
          ListTile(
            leading: Icon(Icons.history, size: 25.0,),
            title: Text('浏览历史', textAlign: TextAlign.left, style: TextStyle(fontSize: 15.0)),
            onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => HistoryPage()));
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.settings, size: 25.0,),
            title: Text('软件设置', textAlign: TextAlign.left, style: TextStyle(fontSize: 15.0)),
            onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => SettingPage()));
            },
          ),
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
            title: Text('测试按钮', textAlign: TextAlign.left, style: TextStyle(fontSize: 15.0)),
            onTap: ()async {
              // Navigator.of(context).push(MaterialPageRoute(builder: (context) => XadminPage());
                String _username = await DataUtils.getUsername();
                bool _isLogin = await DataUtils.getIslogin();
                debugPrint('当前登录的用户名为:$_username, $_isLogin');
            },
          ),
          ListTile(
            leading: Icon(Icons.cancel, size: 25.0,),
            title: Text('退出登录', textAlign: TextAlign.left, style: TextStyle(fontSize: 15.0)),
            //onTap: ()=> Navigator.pop(context),
            onTap : ()async{
              // 这个await必须加,必须先等待用户信息被清除
              await DataUtils.clearLoginStatus();
              String _username = await DataUtils.getUsername();
              bool _isLogin = await DataUtils.getIslogin();
              debugPrint('点击退出登录后用户名为:$_username, $_isLogin');
              Navigator.pop(context);
              if (_isLogin == false)
              {
                Fluttertoast.showToast(
                  msg: "已退出登录",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIos: 1,
                  backgroundColor: Colors.black54,
                  textColor: Colors.white,
                  fontSize: 16.0
                );
              }
            },
          ),
      ],
    )
    );
    }
  }
}
