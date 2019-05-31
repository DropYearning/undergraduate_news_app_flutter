// 首页底部导航栏
import 'package:flutter/material.dart';
import '../Views/LoginPage.dart';
import '../Views/UserPage.dart';
import '../Views/SavePage.dart';
import '../Util/DataUtils.dart';
import 'package:fluttertoast/fluttertoast.dart';


class MyBottomNavigationBar extends StatefulWidget {

  @override
  _MyBottomNavigationBarState createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  //当前选中的哪一栏
  int _currentIndex = 0;
  void _onTapHandler(int index) async {
    setState(() {
      _currentIndex = index ;
    });
    if(index == 1)
    {
      bool _isLogin = await DataUtils.getIslogin();
      if(_isLogin == null || _isLogin == false){
        Fluttertoast.showToast(
            msg: "请先登录",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIos: 1,
            backgroundColor: Colors.black54,
            textColor: Colors.white,
            fontSize: 16.0
          );
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginPage()));
      }else{
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => SavaPage()));
      }
    }
    else if (index == 2)
    {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => SettingPage()));
    }
  }
 
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        iconSize: 24.0 ,
        type: BottomNavigationBarType.fixed,
        currentIndex: 0,
        onTap: _onTapHandler,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('首页'),),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), title: Text('收藏')),
          BottomNavigationBarItem(icon: Icon(Icons.person), title: Text('我的')),
        ],
      );
  }
}