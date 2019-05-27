import 'package:flutter/material.dart';
import '../Widget/RegisterForm.dart';

class LoginPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('注册登录'),
        centerTitle: true,
        elevation: 0.0,
      ),
      // 使用SingleChildScrollView解决弹出键盘超出像素的问题
      body: SingleChildScrollView(
        child: Container(
        // padding: EdgeInsets.all(16.0),
        padding: EdgeInsets.fromLTRB(16.0, 50.0, 16.0, 10.0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // 加载Logo
            Container(
              child: AspectRatio(
                aspectRatio: 3/1,
                child: Image.asset("assets/images/logo-horizontal.png"),
              ),
            ),
            RegisterForm(),
          ],
        ),
      ),
      ),
    );
  }
}



