class Request {
  String reqType; // 'GET' or 'POST' or 'PUT' or 'DELETE'
  String url;     // base を除いたリクエスト先のURL 直で書かないでね
  Map<String, String> headers;
  Map? body;
  Request({required this.reqType, required this.url, this.headers = const {}, this.body});
}
