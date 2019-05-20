// 新闻详情类(供生成新闻详情页使用)
class NewsDetail{
  // 默认构造函数
  const NewsDetail({
    this.id,
    this.title,
    this.channelname,
    this.source,
    this.pubtime,
    this.link,
    this.havepic,
    this.html,
    this.picurl1,
    this.picurl2,
    this.picurl3,
    this.keywords
  });

  final String id;
  final String title;
  final String channelname;
  final String source;
  final String pubtime;
  final String link;
  final int havepic;
  final String html;
  final String picurl1;
  final String picurl2;
  final String picurl3;
  final String keywords;
 
  NewsDetail.fromJson(Map json)
    : title = json['title'],
      id = json['id'],
      channelname = json['channelname'],
      source = json['source'],
      html = json['html'],
      pubtime = json['pubtime'],
      link = json['link'],
      havepic = json['havepic'],
      picurl1 = json['picurl1'],
      picurl2 = json['picurl2'],
      picurl3 = json['picurl3'],
      keywords = json['keywords'];
  
  Map toJson() =>{
    'id' :id,
    'title' : title,
    'channelname' : channelname,
    'source' : source,
    'html' : html,
    'pubtime' : pubtime,
    'link' : link,
    'havepic' : havepic,
    'picurl1' : picurl1,
    'picurl2' : picurl2,
    'picurl3' : picurl3,
    'keywords' : keywords,
  };
}


