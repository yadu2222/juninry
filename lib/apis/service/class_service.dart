import '../http_req.dart';
import '../../models/class_model.dart';
import '../../constant/urls.dart';
import '../../models/req_model.dart';
import 'dart:convert';
import '../../constant/error_handler.dart';

class ClassService {
  // クラスメイト取得
  static Future<List<Map<String, dynamic>>> getClassmates() async {
    // リクエストを生成
    final reqData = Request(url: Urls.getClassmates, reqType: 'GET', headers: {'Content-Type': 'application/json'});
    // リクエストメソッドにオブジェクトを投げる
    final response = await HttpReq.httpReq(reqData);
    ErrorHandler.classErrorHandler(response); // エラーハンドリング
    return Class.resToClassmates(response);
  }

  // クラスに参加
  static Future<String> joinClass(String inviteCode, String? studentNum) async {
    // リクエストを生成
    final reqData = studentNum != ''
        ? Request(
            url: Urls.joinClass,
            reqType: 'POST',
            body: {'studentNumber': int.parse(studentNum!)},
            pasParams: inviteCode,
            headers: {'Content-Type': 'application/json'},
          )
        : Request(
            url: Urls.joinClass,
            reqType: 'POST',
            pasParams: inviteCode,
            headers: {'Content-Type': 'application/json'},
          );

    final response = await HttpReq.httpReq(reqData);
    ErrorHandler.classErrorHandler(response); // エラーハンドリング

    Map resData = jsonDecode(response.body) as Map<String, dynamic>;
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
    final response = await HttpReq.httpReq(reqData);
    ErrorHandler.classErrorHandler(response); // エラーハンドリング
    return Class.resToClass(response);
  }

  // クラス招待コード再発行
  static Future<Class> inviteClass(String classUUID) async {
    // リクエストを生成
    final reqData = Request(url: Urls.inviteClass, reqType: 'PUT', headers: {'Content-Type': 'application/json'}, pasParams: classUUID);
    final response = await HttpReq.httpReq(reqData);
    ErrorHandler.classErrorHandler(response); // エラーハンドリング
    return Class.resToClass(response);
  }

  static Future<List<Class>> getClasses() async {
    // リクエストを生成
    final reqData = Request(url: Urls.getClasses, reqType: 'GET', headers: {'Content-Type': 'application/json'});
    // リクエストメソッドにオブジェクトを投げる
    final response = await HttpReq.httpReq(reqData);
    ErrorHandler.classErrorHandler(response); // エラーハンドリング
    // 返す
    return Class.resToClasses(response);
  }
}
