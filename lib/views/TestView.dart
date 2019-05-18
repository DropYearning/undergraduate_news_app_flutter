import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert'; //用来处理json

class TestView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('测试'),
        elevation: 0.0,
      ),
      body:HttpDemoHome(),
    );
  }
}

class HttpDemoHome extends StatefulWidget {
  @override
  _HttpDemoHomeState createState() => _HttpDemoHomeState();
}

class _HttpDemoHomeState extends State<HttpDemoHome> {
  @override
    void initState(){
      super.initState();
      // fetchPosts()
      //   .then((value) => print(value));



    }
  
 Future<List<Post>> fetchPosts() async{
    final response = await http.get('https://resources.ninghao.net/demo/posts.json');

    if(response.statusCode == 200){
      final responseBody = json.decode(response.body);
      List<Post> posts = responseBody['posts']
        .map<Post>( (item) => Post.fromJson(item) )
        .toList();
    return posts;
    }else{
      throw Exception('Falied');
    }
  

  }
  
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future:fetchPosts(),
      builder: (BuildContext context, AsyncSnapshot snapshot){

        if (snapshot.connectionState == ConnectionState.waiting){
          return Center(
            child: Text('load...') ,
            );
        }

        return ListView(
          children: snapshot.data.map<Widget>((item){
            return ListTile(
              title: Text(item.title),
              subtitle:Text(item.author) ,
              leading: CircleAvatar(
                backgroundImage: NetworkImage(item.imageUrl),
              ),
            );
          }).toList(),
        );
      }
    );
  }
}

class Post{
  final int id;
  final String title;
  final String description;
  final String author;
  final String imageUrl;

  Post(
    this.id,
    this.title,
    this.description,
    this.author,
    this.imageUrl,
  );

  // 另一种构造方法
  Post.fromJson(Map json)
    : title = json['title'],
      description = json['description'],
      id = json['id'],
      author = json['author'],
      imageUrl = json['imageUrl'];
  
  Map toJson() =>{
    'title' :title,
    'description' : description,

  };
}



