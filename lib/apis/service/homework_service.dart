import 'package:flutter/material.dart';

import '../http_req.dart';
import '../../models/homework_model.dart';
import '../../constant/urls.dart';
import '../../models/req_model.dart';

class HomeworkService {
  static Future<List<Map<String, dynamic>>> getHomeworks() async {
    // リクエストを生成
    final reqData = Request(url: Urls.getHomeworks, reqType: 'GET', headers: {'Content-Type': 'application/json'});
    // リクエストメソッドにオブジェクトを投げる
    Map resData = await HttpReq.httpReq(reqData);
    debugPrint(resData.toString());
    // 返す
    return Homework.resToHomeworks(resData['srvResData']);
  }
}
