import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../models/req_model.dart';

class HttpReq {
  static Future<Map> httpReq(Request reqData) async {
    const String baseUrl = 'http://127.0.0.1:4561/v1/auth';
    http.Response response = http.Response('{}', 500); // 初期値を設定（例: 空のレスポンス）;

    // リクエストの種類によって処理を分岐
    switch (reqData.reqType) {
      case 'GET':
        response = await http.get(Uri.parse(baseUrl + reqData.url));
        break;
      case 'POST':
        response = await http.post(Uri.parse(reqData.url),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(reqData.body));
        break;
    }

    // レスポンスの処理
    debugPrint(response.body.toString());
    if (response.statusCode == 200) {
      debugPrint(jsonDecode(response.body));
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {

      // エラーハンドリング
      debugPrint('Error response: ${response.body}');
      return {};
    }
  }
}
