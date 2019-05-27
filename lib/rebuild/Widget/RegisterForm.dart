import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:dio/dio.dart';
import 'dart:async';
import '../Util/DataUtils.dart';

String loginAPI = "http://111.231.57.151:8000/user/";

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final registerFormKey = GlobalKey<FormState>();
  String username, password;
  // 设置是否打开自动表单验证的开关
  bool autovalidateSwitch = false;

  // 通过API请求登录
  fetchLoginStatus() async{
    String loginUrl = loginAPI + username + "/" +password;
    final rsp = await Dio().get(loginUrl);
    final String info = rsp.data['info'];
    final String code = rsp.data['code'];
    debugPrint('本次登录请求的URL为:$loginUrl, info: $info, code $code');
    // 如果登录成功则返回之前的页面
    if(code =='500'){
      Fluttertoast.showToast(
        msg: info,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 1,
        backgroundColor: Colors.black54,
        textColor: Colors.white,
        fontSize: 16.0
      );
      await DataUtils.setLoginStatus(username);
      String _username = await DataUtils.getUsername();
      bool _isLogin = await DataUtils.getIslogin();
      debugPrint('当前登录的用户名为:$_username, $_isLogin');
      Navigator.pop(context);
    }else {
      Fluttertoast.showToast(
        msg: info,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 1,
        backgroundColor: Colors.black54,
        textColor: Colors.white,
        fontSize: 16.0
      );
    }
  }

  // 通过API请求注册
  fetchRegisterStatus() async{
    String loginUrl = loginAPI + username + "/" +password;
    final rsp = await Dio().post(loginUrl);
    final String info = rsp.data['info'];
    final String code = rsp.data['code'];
    debugPrint('本次注册请求的URL为:$loginUrl, info: $info, code $code');
    // 如果注册成功则自动登录
    if(code =='600'){
      await DataUtils.setLoginStatus(username);
      String _username = await DataUtils.getUsername();
      bool _isLogin = await DataUtils.getIslogin();
      debugPrint('当前登录的用户名为:$_username, $_isLogin');
      Navigator.pop(context);
      Fluttertoast.showToast(
        msg: "注册成功,已为您自动登录!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 1,
        backgroundColor: Colors.black54,
        textColor: Colors.white,
        fontSize: 16.0
      );
    }else {
      Fluttertoast.showToast(
        msg: info,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 1,
        backgroundColor: Colors.black54,
        textColor: Colors.white,
        fontSize: 16.0
      );
    }
  }


  // 提交注册表单
  void submitRegisterForm() {
    if (registerFormKey.currentState.validate()) {
      registerFormKey.currentState.save();
      debugPrint('注册: username: $username' + '   password: $password');fetchRegisterStatus();
    } else {
      // 开启自动表单验证功能
      setState(() {
        autovalidateSwitch = true;
      });
    }
  }

  // 提交登录表单
  void submitLoginForm() {
    if (registerFormKey.currentState.validate()) {
      registerFormKey.currentState.save();
      debugPrint('登录: username: $username' + '   password: $password');
      fetchLoginStatus();
    } else {
      setState(() {
        autovalidateSwitch = true;
      });
    }
  }

  // 用户名框表单验证
  String validateUsername(value) {
    if (value.isEmpty) {
      return '用户名不能为空!';
    }
    return null;
  }

  // 密码框表单验证
  String validatePassword(value) {
    if (value.isEmpty) {
      return '密码不能为空!';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: registerFormKey,
      child: Column(
        children: <Widget>[
          // 用户名输入框
          TextFormField(
            decoration: InputDecoration(
              icon: Icon(Icons.person),
              labelText: '用户名',
            ),
            onSaved: (value) {
              username = value; //保存表单内容时赋值
            },
            validator: validateUsername,
            autovalidate: autovalidateSwitch,
          ),
          // 密码输入框
          TextFormField(
            obscureText: true,
            decoration: InputDecoration(
              labelText: '密码',
              icon: Icon(Icons.keyboard),
            ),
            onSaved: (value) {
              password = value; //保存表单内容时赋值
            },
            validator: validatePassword,
            autovalidate: autovalidateSwitch,
          ),
          SizedBox(
            height: 32.0,
          ),
          Container(
            width: double.infinity,
            // 注册按钮
            child: RaisedButton(
              color: Theme.of(context).accentColor,
              child: Text(
                '注册',
                style: TextStyle(color: Colors.white),
              ),
              elevation: 0.0,
              onPressed: submitRegisterForm, // 注意不用括号
            ),
          ),
          Container(
            width: double.infinity,
            // 登录按钮
            child: RaisedButton(
              color: Theme.of(context).accentColor,
              child: Text(
                '登录',
                style: TextStyle(color: Colors.white),
              ),
              elevation: 0.0,
              onPressed: submitLoginForm, // 注意不用括号
            ),
          ),
        ],
      ),
    );
  }
}
