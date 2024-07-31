import 'package:flutter/material.dart';

import '../http_req.dart';
import '../../models/help_model.dart';
import '../../constant/urls.dart';
import '../../models/req_model.dart';
// import 'package:http/http.dart' as http;
// import '../error.dart';

class HelpService {
  // TODO:エラーハンドリング
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

  // おてつだい消化
  static Future<int> destionHelp(Help help) async {
    // リクエストを生成
    final reqData = Request(url: Urls.destionHelp, reqType: 'POST', body: {'helpUUID': help.helpUuid}, headers: {'Content-Type': 'application/json'});
    // リクエストメソッドにオブジェクトを投げる
    Map resData = await HttpReq.httpReq(reqData);
    return resData['srvResData']['ouchiPoint'];
  }

  // おてつだい登録
  static Future<void> registerHelp(Help help) async {
    // リクエストを生成
    final reqData = Request(url: Urls.registerHelp, reqType: 'POST', body: Help.helpToMap(help), headers: {'Content-Type': 'application/json'});
    // リクエストメソッドにオブジェクトを投げる
    await HttpReq.httpReq(reqData);
  }
}
