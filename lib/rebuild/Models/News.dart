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




// 测试数据
  List<News> addNewsList = [
  News(
    id: "00b4f780c5a803286a2ce735ff454ffa" ,
    title: "1瓜子二手车严选直卖店宣布落地深圳 华南区业绩位居全国第一",
    channelname: "汽车",
    source: "TechWeb",
    pubtime: "2019-03-23 14:47:32",
    savetime: "2019-03-23 14:47:32",
    link: "http://baijiahao.baidu.com/s?id=1628776552960010950&wfr=newsapp",
    havepic: 1,
    picurl1: "http://pics2.baidu.com/feed/80cb39dbb6fd5266e9616326012e182fd4073670.jpeg?token=4fffe52dc97cefebfe461c917e9cbc59&s=BFA1E90344715D8E688088F10100C0B3",
    picurl2: "",
    picurl3: "",
    keywords: '测试1/测试2/测试3',
  ),  
    News(
    id: "00b4f780c5a803286a2ce735ff454ffa" ,
    title: "2瓜子二手车严选直卖店宣布落地深圳 华南区业绩位居全国第一",
    channelname: "汽车",
    source: "TechWeb",
    pubtime: "2019-03-23 14:47:32",
    savetime: "2019-03-23 14:47:32",
    link: "http://baijiahao.baidu.com/s?id=1628776552960010950&wfr=newsapp",
    havepic: 1,
    picurl1: "http://pics2.baidu.com/feed/80cb39dbb6fd5266e9616326012e182fd4073670.jpeg?token=4fffe52dc97cefebfe461c917e9cbc59&s=BFA1E90344715D8E688088F10100C0B3",
    picurl2: "",
    picurl3: "",
    keywords: '测试1/测试2/测试3',
  ),  
    News(
    id: "00b4f780c5a803286a2ce735ff454ffa" ,
    title: "3瓜子二手车严选直卖店宣布落地深圳 华南区业绩位居全国第一",
    channelname: "汽车",
    source: "TechWeb",
    pubtime: "2019-03-23 14:47:32",
    savetime: "2019-03-23 14:47:32",
    link: "http://baijiahao.baidu.com/s?id=1628776552960010950&wfr=newsapp",
    havepic: 1,
    picurl1: "http://pics2.baidu.com/feed/80cb39dbb6fd5266e9616326012e182fd4073670.jpeg?token=4fffe52dc97cefebfe461c917e9cbc59&s=BFA1E90344715D8E688088F10100C0B3",
    picurl2: "",
    picurl3: "",
    keywords: '测试1/测试2/测试3',
  ),  
    News(
    id: "00b4f780c5a803286a2ce735ff454ffa" ,
    title: "4瓜子二手车严选直卖店宣布落地深圳 华南区业绩位居全国第一",
    channelname: "汽车",
    source: "TechWeb",
    pubtime: "2019-03-23 14:47:32",
    savetime: "2019-03-23 14:47:32",
    link: "http://baijiahao.baidu.com/s?id=1628776552960010950&wfr=newsapp",
    havepic: 1,
    picurl1: "http://pics2.baidu.com/feed/80cb39dbb6fd5266e9616326012e182fd4073670.jpeg?token=4fffe52dc97cefebfe461c917e9cbc59&s=BFA1E90344715D8E688088F10100C0B3",
    picurl2: "",
    picurl3: "",
    keywords: '测试1/测试2/测试3',
  ),  
    News(
    id: "00b4f780c5a803286a2ce735ff454ffa" ,
    title: "5瓜子二手车严选直卖店宣布落地深圳 华南区业绩位居全国第一",
    channelname: "汽车",
    source: "TechWeb",
    pubtime: "2019-03-23 14:47:32",
    savetime: "2019-03-23 14:47:32",
    link: "http://baijiahao.baidu.com/s?id=1628776552960010950&wfr=newsapp",
    havepic: 1,
    picurl1: "http://pics2.baidu.com/feed/80cb39dbb6fd5266e9616326012e182fd4073670.jpeg?token=4fffe52dc97cefebfe461c917e9cbc59&s=BFA1E90344715D8E688088F10100C0B3",
    picurl2: "",
    picurl3: "",
    keywords: '测试1/测试2/测试3',
  )];