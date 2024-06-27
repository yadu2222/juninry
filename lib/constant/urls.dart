class Urls {
  
  // base URL
  static const String protocol = 'http://';
  static const String host = '127.0.0.1';
  static const String port = '4561';
  static const String baseUrl = protocol + host + ':' + port;
  static const String version = '/v1'; // version

  // ここにURLを追加していく
  static const String getUser = version + '/auth/users/user';

}