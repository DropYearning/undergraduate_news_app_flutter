// main.dart只作为App入口函数
import 'package:flutter/material.dart';
import './rebuild//Views/HomePage.dart';

void main() {
  runApp(NewsApp());
}

// StatelessWidget表示其是不拥有状态的部件
class NewsApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // App后台名字
      title: 'NewsHub Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // 定义根路由
      initialRoute: '/',
      // 定义有名路由
      routes: {
        '/': (context) => HomePage(), 
      },
    );
  }
}
