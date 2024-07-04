import 'package:flutter/material.dart';

import '../http_req.dart';
import '../../models/class_model.dart';
import '../../constant/urls.dart';
import '../../models/req_model.dart';

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
}
