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
  static Future<String> joinClass(String inviteCode, Map<String, dynamic> Function(http.Response) errorHandling) async {
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
  static Future<Class> createClass(String className) async {
    // リクエストを生成
    final reqData = Request(
      url: Urls.createClass,
      reqType: 'POST',
      body: {'className': className},
      headers: {'Content-Type': 'application/json'},
    );
    final resData = await HttpReq.httpReq(reqData);
    return Class.resToClass(resData['srvResData']);
  }

  // クラス招待コード再発行
  static Future<Class> inviteClass(String classUUID) async {
    // リクエストを生成
    final reqData = Request(url: Urls.inviteClass, reqType: 'PUT', headers: {'Content-Type': 'application/json'}, parData: classUUID);
    final resData = await HttpReq.httpReq(reqData);
    return Class.resToClass(resData['srvResData']);
  }

  static Future<List<Class>> getClasses() async {
    // リクエストを生成
    final reqData = Request(
        url: Urls.getClasses,
        reqType: 'GET',
        headers: {'Content-Type': 'application/json'});
    // リクエストメソッドにオブジェクトを投げる
    final resData = await HttpReq.httpReq(reqData);
    debugPrint(resData.toString());
    List<Class> classList = [];
    for (Map c in resData['srvResData']['classes']) {
      debugPrint(c.toString());
      classList.add(Class.resToClass(c));
    }
    // 返す
    return classList;
  }
}
