class Urls {
  // base URL
  static const String protocol = 'http://';
  static const String host = '127.0.0.1';
  static const String port = '4561';
  static const String baseUrl = '$protocol$host:$port';
  static const String version = '/v1'; // version

  // ここにURLを追加していく
  // user
  static const String registerUser = '$version/users/register'; // POSTユーザー登録
  static const String login = '$version/users/login'; // POSTログイン
  static const String getUser = '$version/auth/users/user'; // GETuser情報取得

  // notice

  // homework
  static const String getHomeworks = '$version/auth/users/homeworks/upcoming'; // GET宿題取得
  static const String getNextdayHomeworks = '$version/auth/users/homeworks/nextday'; // GETつぎのひの宿題取得

  // class
  static const String getClassmates = '$version/auth/users/classes/users'; // GETクラスメイト取得


}
