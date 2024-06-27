import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../models/req_model.dart';
import '../../models/user_model.dart';
import '../../constant/urls.dart';

class HttpReq {
  static Future<Map> httpReq(Request reqData) async {
    User user = await User.getUser(); // user情報をdbから取得
    reqData.headers['Authorization'] = user.jwtKey; // ヘッダーに認証トークンを追加
    http.Response response = http.Response('{}', 500); // 初期値を設定（例: 空のレスポンス）;
    // リクエストの種類によって処理を分岐
    switch (reqData.reqType) {
      case 'GET':
        response = await http.get(
          Uri.parse(Urls.baseUrl + reqData.url),
          headers: reqData.headers,
        );
        break;
      case 'POST':
        response = await http.post(Uri.parse(reqData.url), headers: reqData.headers, body: jsonEncode(reqData.body));
        break;
    }
    // レスポンスの処理
    debugPrint(response.body.toString());
    // 成功
    if (response.statusCode < 300) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    // 失敗時の処理
    } else {
      return reqData.errorHandling(response);
    }
  }
}
