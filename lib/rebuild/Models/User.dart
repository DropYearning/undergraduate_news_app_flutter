// 用户类
class User{

  const User({
    this.username,
    this.password,
  });

  final String username;
  final String password;

  User.fromJson(Map json)
    : username = json['username'],
      password = json['password'];

  Map toJson() =>{
    'username' :username,
    'password' : password,
  };
  
}