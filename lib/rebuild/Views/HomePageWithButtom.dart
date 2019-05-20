import 'package:flutter/material.dart';
import './NewsColumn.dart';

class HomePageWithButtom extends StatefulWidget {
  HomePageWithButtom({Key key}) : super(key: key);

  @override
  _HomePageWithButtomState createState() => _HomePageWithButtomState();
}

class _HomePageWithButtomState extends State<HomePageWithButtom> {




  int _selectedIndex = 1;
  final _widgetOptions = [
    NewsColumn(),
    Text('Index 1: Business'),
    Text('Index 2: School'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BottomNavigationBar Sample'),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Home')),
          BottomNavigationBarItem(icon: Icon(Icons.business), title: Text('Business')),
          BottomNavigationBarItem(icon: Icon(Icons.school), title: Text('School')),
        ],
        currentIndex: _selectedIndex,
        fixedColor: Colors.deepPurple,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    debugPrint('now $index' );
  }
}