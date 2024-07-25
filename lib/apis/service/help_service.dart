import 'package:flutter/material.dart';

import '../http_req.dart';
import '../../models/help_model.dart';
import '../../constant/urls.dart';
import '../../models/req_model.dart';
import 'package:http/http.dart' as http;
import '../error.dart';

class HelpService {
  // おてつだい取得
  static Future<List<Help>> getHelps() async {
    // リクエストを生成
    final reqData = Request(url: Urls.getHelp, reqType: 'GET', headers: {'Content-Type': 'application/json'});
    // リクエストメソッドにオブジェクトを投げる
    Map resData = await HttpReq.httpReq(reqData);
    debugPrint(resData.toString());
    // 返す
    return Help.resToHelps(resData['srvResData']);
  }
}
