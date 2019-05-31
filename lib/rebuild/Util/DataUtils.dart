// 使用shared_preferences持久化存储数据的工具类
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';


class DataUtils{
  // 设置shared_preferences中存储两个数据所用的"key",类似于变量名故使用String
  static const String SP_USERNAME="username";
  static const String SP_IS_LOGIN = "isLogin";
  static const String SP_FONT_SIZE = "fontSize";

  // 初始化字体大小为17
  static initFontSize()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(SP_FONT_SIZE, 17);
  }

  // 获取当前字体大小
  static Future<int> getFontSize()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int fontSize = prefs.getInt(SP_FONT_SIZE);
    return  fontSize;
  }

  // 设置字体大小
  static setFontSize(int fontSize)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(SP_FONT_SIZE, fontSize);
  }


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






