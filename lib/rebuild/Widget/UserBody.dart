// 设置页主体Body
import 'package:flutter/material.dart';
import '../Views/XadminPage.dart';
import '../Views/LoginPage.dart';
import '../Views/HistoryPage.dart';
import '../Views/SavePage.dart';
import '../Views/UserPage.dart';
import '../Util/DataUtils.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:async';

// 已登录用户的设置页主体
class SettingPageBodyLoged extends StatefulWidget {
  final String username;
  SettingPageBodyLoged({Key key, @required this.username}) : super(key: key);
  @override
  _SettingPageBodyLogedState createState() => _SettingPageBodyLogedState();
}

class _SettingPageBodyLogedState extends State<SettingPageBodyLoged> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      // 去掉顶部灰色区域
      padding: EdgeInsets.all(0),
      // 所有抽屉中的子组件都定义到这里：
      children: <Widget>[
        Divider(
          height: 50.0,
          color: Colors.white,
        ),
        Container(
          width: 120.0,
          height: 120.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage('assets/images/LoginAvatar.jpeg'),
            ),
          ),
        ),
        Divider(
          color: Colors.white,
        ),
        ListTile(
          leading: Icon(
            Icons.star,
            size: 25.0,
          ),
          title: Text('我的收藏',
              textAlign: TextAlign.left, style: TextStyle(fontSize: 15.0)),
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => SavaPage()));
          },
          trailing: Icon(
            Icons.keyboard_arrow_right,
            size: 25.0,
          ),
        ),
        ListTile(
          leading: Icon(
            Icons.history,
            size: 25.0,
          ),
          title: Text('浏览历史',
              textAlign: TextAlign.left, style: TextStyle(fontSize: 15.0)),
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => HistoryPage()));
          },
          trailing: Icon(
            Icons.keyboard_arrow_right,
            size: 25.0,
          ),
        ),
        ListTile(
          leading: Icon(
            Icons.add_to_home_screen,
            size: 25.0,
          ),
          title: Text('后台管理',
              textAlign: TextAlign.left, style: TextStyle(fontSize: 15.0)),
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => XadminPage()));
          },
          trailing: Icon(
            Icons.keyboard_arrow_right,
            size: 25.0,
          ),
        ),
        ListTile(
          leading: Icon(
            Icons.adb,
            size: 25.0,
          ),
          title: Text('测试按钮',
              textAlign: TextAlign.left, style: TextStyle(fontSize: 15.0)),
          onTap: () async {
            String _username = await DataUtils.getUsername();
            bool _isLogin = await DataUtils.getIslogin();
            debugPrint('当前登录的用户名为:$_username, $_isLogin');
          },
          trailing: Icon(
            Icons.keyboard_arrow_right,
            size: 25.0,
          ),
        ),
        ListTile(
          leading: Icon(
            Icons.delete_sweep,
            size: 25.0,
          ),
          title: Text('清理缓存',
              textAlign: TextAlign.left, style: TextStyle(fontSize: 15.0)),
          onTap: () {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text("清理中..."),
                action: SnackBarAction(
                  label: "ok",
                  onPressed: () {},
                ),
              ),
            );
          },
          trailing: Icon(
            Icons.keyboard_arrow_right,
            size: 25.0,
          ),
        ),
        ListTile(
          leading: Icon(
            Icons.help_outline,
            size: 25.0,
          ),
          title: Text('关于项目',
              textAlign: TextAlign.left, style: TextStyle(fontSize: 15.0)),
          onTap: () {
            showDialog(
              context: context,
              builder: (_)=>AboutDialog(
                applicationName: 'Newshub Demo',
                applicationIcon: Icon(Icons.help_outline),
                applicationVersion: 'v1.0',
                children: <Widget>[
                  Text('HDU2019毕业设计'),
                  Text('15051349 周亮'),
                  Text('基于Android的新闻推荐客户端设计与实现'),
                ],
              )
            );
          },
          trailing: Icon(
            Icons.keyboard_arrow_right,
            size: 25.0,
          ),
        ),
        ListTile(
          leading: Icon(
            Icons.cancel,
            size: 25.0,
          ),
          title: Text('退出登录',
              textAlign: TextAlign.left, style: TextStyle(fontSize: 15.0)),
          onTap: () async {
            // 这个await必须加,必须先等待用户信息被清除
            await DataUtils.clearLoginStatus();
            String _username = await DataUtils.getUsername();
            bool _isLogin = await DataUtils.getIslogin();
            debugPrint('点击退出登录后用户名为:$_username, $_isLogin');
            Navigator.pop(context);
            if (_isLogin == false) {
              Fluttertoast.showToast(
                  msg: "已退出登录",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIos: 1,
                  backgroundColor: Colors.black54,
                  textColor: Colors.white,
                  fontSize: 16.0);
            }
          },
          trailing: Icon(
            Icons.keyboard_arrow_right,
            size: 25.0,
          ),
        ),
      ],
    );
  }
}

// 未登录用户的设置页主体
class SettingPageBodyUnloged extends StatefulWidget {
  @override
  _SettingPageBodyUnlogedState createState() => _SettingPageBodyUnlogedState();
}

class _SettingPageBodyUnlogedState extends State<SettingPageBodyUnloged> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Divider(
          height: 50.0,
          color: Colors.white,
        ),
        Container(
          //padding: EdgeInsets.fromLTRB(0.0, 80.0, 0.0, 30.0),
          width: 120.0,
          height: 120.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage('assets/images/defaultAvatar.jpeg'),
            ),
          ),
        ),
        Divider(
          color: Colors.white,
        ),
        ListTile(
          leading: Icon(
            Icons.portrait,
            size: 25.0,
          ),
          title: Text('注册登陆',
              textAlign: TextAlign.left, style: TextStyle(fontSize: 15.0)),
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => LoginPage()));
          },
          trailing: Icon(
            Icons.keyboard_arrow_right,
            size: 25.0,
          ),
        ),
        ListTile(
          leading: Icon(
            Icons.add_to_home_screen,
            size: 25.0,
          ),
          title: Text('后台管理',
              textAlign: TextAlign.left, style: TextStyle(fontSize: 15.0)),
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => XadminPage()));
          },
          trailing: Icon(
            Icons.keyboard_arrow_right,
            size: 25.0,
          ),
        ),
        ListTile(
          leading: Icon(
            Icons.adb,
            size: 25.0,
          ),
          title: Text('测试按钮',
              textAlign: TextAlign.left, style: TextStyle(fontSize: 15.0)),
          onTap: () async {
            String _username = await DataUtils.getUsername();
            bool _isLogin = await DataUtils.getIslogin();
            debugPrint('当前登录的用户名为:$_username, $_isLogin');
          },
          trailing: Icon(
            Icons.keyboard_arrow_right,
            size: 25.0,
          ),
        ),
        ListTile(
          leading: Icon(
            Icons.delete_sweep,
            size: 25.0,
          ),
          title: Text('清理缓存',
              textAlign: TextAlign.left, style: TextStyle(fontSize: 15.0)),
          onTap: () {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text("清理中..."),
                action: SnackBarAction(
                  label: "ok",
                  onPressed: () {},
                ),
              ),
            );
          },
          trailing: Icon(
            Icons.keyboard_arrow_right,
            size: 25.0,
          ),
        ),
        ListTile(
          leading: Icon(
            Icons.help_outline,
            size: 25.0,
          ),
          title: Text('关于项目',
              textAlign: TextAlign.left, style: TextStyle(fontSize: 15.0)),
          onTap: () {
            showDialog(
              context: context,
              builder: (_)=>AboutDialog(
                applicationName: 'Newshub Demo',
                applicationIcon: Icon(Icons.help_outline),
                applicationVersion: 'v1.0',
                children: <Widget>[
                  Text('HDU2019毕业设计'),
                  Text('15051349 周亮'),
                  Text('基于Android的新闻推荐客户端设计与实现'),
                ],
              )
            );
          },
          trailing: Icon(
            Icons.keyboard_arrow_right,
            size: 25.0,
          ),
        ),
      ],
    );
  }
}
