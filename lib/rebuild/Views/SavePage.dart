// SavePage 用户收藏页面
import 'package:flutter/material.dart';
import '../Widget/SaveBody.dart';

class SavaPage extends StatefulWidget {
  @override
  _SavaPageState createState() => _SavaPageState();
}

class _SavaPageState extends State<SavaPage> {
  @override
  Widget build(BuildContext context) {
   return Scaffold(
      appBar: AppBar(
        title: Text('用户收藏'),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: SaveBody(),
    );
  }
}