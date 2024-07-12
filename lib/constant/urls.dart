class Urls {
  // base URL
  static const String protocol = 'http://';
  static const String host = '10.0.2.2';
  static const String port = '4561';
  static const String baseUrl = '$protocol$host:$port';
  static const String version = '/v1'; // version

  // ここにURLを追加していく
  // user
  static const String registerUser = '$version/users/register'; // POSTユーザー登録
  static const String login = '$version/users/login'; // POSTログイン
  static const String getUser = '$version/auth/users/user'; // GETuser情報取得

  // notice
  static const String getNotices = '$version/auth/users/notice/notices'; // GETお知らせ取得
  // homework
  static const String getHomeworks = '$version/auth/users/homeworks/upcoming'; // GET宿題取得

  // class


}
