import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('注册登录'),
        centerTitle: true,
        elevation: 0.0,
        
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RegisterForm(),
          ],
        ),
      ),
    );
  }
}


class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final registerFormKey = GlobalKey<FormState>();
  String username, password;
  // 设置是否打开自动表单验证的开关
  bool autovalidateSwitch = false;

  void submitRegisterForm() {
    if (registerFormKey.currentState.validate()) {
      registerFormKey.currentState.save();
      debugPrint('username: $username' + '   password: $password');
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('正在注册...'),
        action: SnackBarAction(
          label: 'ok',
          onPressed: () {},
        ),
      ));
    } else {
      setState(() {
        autovalidateSwitch = true;
      });
    }
  }

  String validateUsername(value) {
    if (value.isEmpty) {
      return '用户名不能为空!';
    }

    return null;
  }

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
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Username',
            ),
            onSaved: (value) {
              username = value; //保存表单内容时赋值
            },
            validator: validateUsername,
            autovalidate: autovalidateSwitch,
          ),
          TextFormField(
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Password',
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
        ],
      ),
    );
  }
}
