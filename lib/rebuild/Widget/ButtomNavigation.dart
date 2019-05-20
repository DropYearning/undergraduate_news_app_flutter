import 'package:flutter/material.dart';
import '../Views/LoginPage.dart';

// 底部导航栏
class MyBottomNavigationBar extends StatefulWidget {

  @override
  _MyBottomNavigationBarState createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  
  //当前选中的哪一栏
  int _currentIndex = 0;
  void _onTapHandler(int index){
    setState(() {
      _currentIndex = index ;
    });
    if(index == 1)
    {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginPage()));
    }
    else if (index == 2)
    {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginPage()));
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
          BottomNavigationBarItem(icon: Icon(Icons.favorite), title: Text('推荐')),
          BottomNavigationBarItem(icon: Icon(Icons.person), title: Text('用户')),
        ],
      );
  }
}