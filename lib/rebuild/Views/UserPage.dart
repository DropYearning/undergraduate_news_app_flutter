// 设置页
import 'package:flutter/material.dart';
import '../Views/XadminPage.dart';
import '../Views/LoginPage.dart';
import '../Views/HistoryPage.dart';
import '../Views/SavePage.dart';
import '../Views/UserPage.dart';
import '../Util/DataUtils.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:async';
import '../Widget/UserBody.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {

  bool _isLogin;
  String _username;

  setStatus()async{
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
    setStatus();
  }

  @override
  Widget build(BuildContext context) {
    // 如果当前没有用户登录
    if(_isLogin==null || _isLogin==false){
      return Scaffold(
        appBar: AppBar(
        title: Text('用户设置'),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: SettingPageBodyUnloged(),
    );
    // 假如有用户登录
    }else{
      return Scaffold(
        appBar: AppBar(
        title: Text('用户设置'),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: SettingPageBodyLoged(username: _username,),
    );
    }
  }
}


