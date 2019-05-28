// 用户访问历史项

class HistoryItem{
  const HistoryItem({
    this.username,
    this.news_id,
    this.news_title,
    this.news_channel,
    this.news_keywords,
    this.savetime,
  });

  final String username;
  final String news_id;
  final String news_title;
  final String news_keywords;
  final String news_channel;
  final String savetime;

  HistoryItem.fromJson(Map json)
    : username = json['username'],
      news_id = json['news_id'],
      news_title = json['news_title'],
      news_keywords = json['news_keywords'],
      news_channel = json['news_channel'],
      savetime = json['savetime'];
  
  Map toJson() =>{
    'username' :username,
    'news_id' : news_id,
    'news_title' : news_title,
    'news_keywords' : news_keywords,
    'news_channel' : news_channel,
    'savetime' : savetime,
  };
}