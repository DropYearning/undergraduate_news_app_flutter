import 'package:flutter/material.dart';


class ChannelSelect extends StatefulWidget {
  final String title; //appbar标题
  ChannelSelect({
    this.title = '频道选择',
  });

  @override
  _ChannelSelectState createState() => _ChannelSelectState();
}

class _ChannelSelectState extends State<ChannelSelect> {
    List _allChannels = [
    "国内",
    "国际",
    "财经",
    "娱乐",
    "汽车",
    "军事",
    "社会",
    "体育",
    "教育",
    "数码",
    "游戏",
    "科技",
    "互联网",
    "房地产",
  ]; 

    List _showedChannels = [
    "国内",
    "国际",
    "财经",
    "娱乐",
    "汽车",
    "军事",
    "社会",
    "体育",
    "教育",
    "数码",
    "游戏",
    "科技",
    "互联网",
    "房地产",
  ]; 

  List<String> _selectedChaneels = [];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        actions: <Widget>[
          // 确认提交按钮
          IconButton(icon: Icon(Icons.done), onPressed: () {
              
            }
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
                "请选择要在首页显示的频道: ",style: TextStyle(fontSize: 22),
              ),
            SizedBox(
              height: 20.0,
            ),
            Divider(color: Colors.black54,),
            SizedBox(
              height: 20.0,
            ),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: _allChannels.map ((tag){
                  return FilterChip(
                    label: Text(tag),
                    selected: _selectedChaneels.contains(tag),
                    onSelected: (value){
                        setState(() {
                          if (_selectedChaneels.contains(tag)) {
                            _selectedChaneels.remove(tag);
                          } else {
                            _selectedChaneels.add(tag);
                          }
                        });
                    },
                  );
                }
              ).toList(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.undo),
        onPressed: (){
          setState(() {
            _selectedChaneels = [];
          });
        },
      ),
    );
  }
}