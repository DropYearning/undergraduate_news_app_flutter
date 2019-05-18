// 新闻数据模型类(缺少HTML和content字段, 供生成新闻列表视图用)
class News{
  // 默认构造函数
  const News({
    this.id,
    this.title,
    this.channelname,
    this.source,
    this.pubtime,
    this.savetime,
    this.link,
    this.havepic,
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
  final String savetime;
  final String link;
  final int havepic;
  final String picurl1;
  final String picurl2;
  final String picurl3;
  final String keywords;
 
  News.fromJson(Map json)
    : title = json['title'],
      id = json['id'],
      channelname = json['channelname'],
      source = json['source'],
      savetime = json['savetime'],
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
    'savetime' : savetime,
    'pubtime' : pubtime,
    'link' : link,
    'havepic' : havepic,
    'picurl1' : picurl1,
    'picurl2' : picurl2,
    'picurl3' : picurl3,
    'keywords' : keywords,
  };




}


