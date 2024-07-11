import 'package:flutter/material.dart';

import '../http_req.dart';
import '../../models/class_model.dart';
import '../../constant/urls.dart';
import '../../models/req_model.dart';
import 'package:http/http.dart' as http;


class ClassService {
  static Future<List<Map<String, dynamic>>> getClassmates() async {
    // リクエストを生成
    debugPrint("1");
    final reqData = Request(url: Urls.getClassmates, reqType: 'GET', headers: {'Content-Type': 'application/json'});
    // リクエストメソッドにオブジェクトを投げる
    debugPrint("2");
    Map resData = await HttpReq.httpReq(reqData);
    debugPrint("3");
    debugPrint(resData.toString());
    // 返す
    return Class.resToClassmates(resData['srvResData']);
  }

  // クラスに参加
  static Future<String> joinClass(String inviteCode, Map<String,dynamic> Function(http.Response) errorHandling) async {
    // リクエストを生成
    final reqData = Request(
      url: Urls.joinClass,
      reqType: 'POST',
      parData: inviteCode,
      headers: {'Content-Type': 'application/json'},
      errorHandling: errorHandling,
    );
    final resData = await HttpReq.httpReq(reqData);
    return resData['srvResData']['className'];
  }

  // クラス作成
  static Future<String> createClass(String className) async {
    // リクエストを生成
    final reqData = Request(
      url: Urls.createClass,
      reqType: 'POST',
      body:{'className':className},
      headers: {'Content-Type': 'application/json'},
    );
    final resData = await HttpReq.httpReq(reqData);
    return resData['srvResData']['inviteCode'];
  }
}
