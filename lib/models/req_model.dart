class Request {
  String reqType;
  String url;
  Map? headers;
  Map? body;
  Request({required this.reqType, required this.url,this.headers, this.body});
}
