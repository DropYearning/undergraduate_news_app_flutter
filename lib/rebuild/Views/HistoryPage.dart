// HistoryPage 用户历史页
import 'package:flutter/material.dart';

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
   return Scaffold(
      appBar: AppBar(
        title: Text('用户历史'),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Container(),
    );
  }
}