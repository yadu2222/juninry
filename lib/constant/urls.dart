class Urls {
  // base URL
  static const String protocol = 'http://';
  static const String host = 'localhost';
  static const String port = '4561';
  static const String baseUrl = protocol + host + ':' + port;
  static const String version = '/v1'; // version


  // ここにURLを追加していく
  static const String getUser = version + '/auth/users/user';





  // 課題の詳細情報取得　
static String getNoticeDetail(String noticeUuid) {
    return '$version/auth/users/notices/$noticeUuid';
  }
}
