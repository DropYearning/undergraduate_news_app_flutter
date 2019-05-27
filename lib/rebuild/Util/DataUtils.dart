import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class DataUtils{
  // 设置shared_preferences中存储两个数据所用的"key",类似于变量名故使用String
  static const String SP_USERNAME="username";
  static const String SP_IS_LOGIN = "isLogin";

  // 登录后写入用户信息
  static setLoginStatus(String username) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(SP_IS_LOGIN, true);
    await prefs.setString(SP_USERNAME, username);
  }

  // 获取当前登录状态
  static Future<bool>getIslogin() async{
    bool isLogin;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isLogin = prefs.getBool(SP_IS_LOGIN);
    return isLogin;
  }

  // 获取当前登录用户名
  static Future<String> getUsername() async{
    String username;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    username = prefs.getString(SP_USERNAME);
    return username;
  }

  // 退出登录后清除用户信息
  static clearLoginStatus() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(SP_IS_LOGIN, false);
    await prefs.setString(SP_USERNAME, "");
  }
}






