import 'package:flutter/material.dart';

import '../http_req.dart';
import '../../models/class_model.dart';
import '../../constant/urls.dart';
import '../../models/req_model.dart';
import 'package:http/http.dart' as http;
import '../error.dart';

class ClassService {
  // クラスメイト取得
  static Future<List<Map<String, dynamic>>> getClassmates() async {
    // リクエストを生成
    final reqData = Request(url: Urls.getClassmates, reqType: 'GET', headers: {'Content-Type': 'application/json'});
    // リクエストメソッドにオブジェクトを投げる
    Map resData = await HttpReq.httpReq(reqData);
    debugPrint(resData.toString());
    // 返す
    return Class.resToClassmates(resData['srvResData']);
  }

  // クラスに参加
  static Future<String> joinClass(String inviteCode, String? studentNum) async {
    // エラーハンドリング
    errorHandling(http.Response response) {
      if (response.statusCode == 403) {
        throw PermittionError(); // 親にはその権限がないよ
      } else if (response.statusCode == 409) {
        throw JoinClassConflictException(); // すでに参加している場合をthrow
      } else {
        throw DefaultException();
      }
    }

    // リクエストを生成
    final reqData = studentNum != ''
        ? Request(
            url: Urls.joinClass,
            reqType: 'POST',
            body: {'studentNumber': int.parse(studentNum!)},
            pasParams: inviteCode,
            headers: {'Content-Type': 'application/json'},
            errorHandling: errorHandling,
          )
        : Request(
            url: Urls.joinClass,
            reqType: 'POST',
            pasParams: inviteCode,
            headers: {'Content-Type': 'application/json'},
            errorHandling: errorHandling,
          );

    try {
      final resData = await HttpReq.httpReq(reqData);
      return resData['srvResData']['className'];
    } catch (e) {
      rethrow;
    }
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
    final reqData = Request(url: Urls.inviteClass, reqType: 'PUT', headers: {'Content-Type': 'application/json'}, pasParams: classUUID);
    final resData = await HttpReq.httpReq(reqData);
    return Class.resToClass(resData['srvResData']);
  }

  static Future<List<Class>> getClasses() async {
    // リクエストを生成
    final reqData = Request(url: Urls.getClasses, reqType: 'GET', headers: {'Content-Type': 'application/json'});
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
