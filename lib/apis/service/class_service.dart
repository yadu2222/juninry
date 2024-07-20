import 'package:flutter/material.dart';

import '../http_req.dart';
import '../../models/class_model.dart';
import '../../constant/urls.dart';
import '../../models/req_model.dart';
import 'package:http/http.dart' as http;
import '../error.dart';

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
  static Future<String> joinClass(String inviteCode,) async {

    // こうやってthrowしてcatchで拾うのはどうだろうか
    errorHandling(http.Response response) {
      if (response.statusCode == 403) {
        throw const PermittionError(); // 親にはその権限がないよ
      } else if (response.statusCode == 409) {
        throw const JoinClassConflictException(); // すでに参加している場合をthrow
      } else {
        throw Exception('クラス参加に失敗しました');
      }
    }

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
    List<Class> classList = [];
    for (Map c in resData['srvResData']['classes']) {
      classList.add(Class.resToClass(c));
    }
    // 返す
    return classList;
  }

}
