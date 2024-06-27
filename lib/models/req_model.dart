class Request {
  String reqType; // 'GET' or 'POST' or 'PUT' or 'DELETE'
  String url;     // base を除いたリクエスト先のURL 直で書かないでね
  Map<String, String> headers;  // ヘッダー Authorizationは除いてね
  Map? body;    // body
  Request({required this.reqType, required this.url, this.headers = const {}, this.body});
}
