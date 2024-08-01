import 'package:flutter/material.dart';

import '../http_req.dart';
import '../../models/reward_model.dart';
import '../../constant/urls.dart';
import '../../models/req_model.dart';
import '../../models/exchange_model.dart';
// import 'package:http/http.dart' as http;
// import '../error.dart';

class RewardService {
  // TODO:エラーハンドリング
  // ごほうび取得
  static Future<List<Reward>> getReward() async {
    // リクエストを生成
    final reqData = Request(url: Urls.getRewards, reqType: 'GET', headers: {'Content-Type': 'application/json'});
    // リクエストメソッドにオブジェクトを投げる
    Map resData = await HttpReq.httpReq(reqData);
    debugPrint(resData.toString());
    // 返す
    return Reward.resToReward(resData['srvResData']);
  }

  // ごほうび交換
  static Future<int> exchangeReward(Reward reward) async {
    // リクエストを生成
    final reqData = Request(url: Urls.exchangeReward, reqType: 'POST', body: {'rewardUUID': reward.rewardUuid}, headers: {'Content-Type': 'application/json'});
    // リクエストメソッドにオブジェクトを投げる
    Map resData = await HttpReq.httpReq(reqData);
    return resData['srvResData']['ouchiPoint'];
  }

  // ごほうび登録
  static Future<void> registerReward(Reward reward) async {
    // リクエストを生成
    final reqData = Request(url: Urls.registerReward, reqType: 'POST', body: Reward.rewardToMap(reward), headers: {'Content-Type': 'application/json'});
    // リクエストメソッドにオブジェクトを投げる
    await HttpReq.httpReq(reqData);
  }

  // 交換されたごほうびを取得
  static Future<List<Exchange>> getExchange() async {
    // リクエストを生成
    final reqData = Request(url: Urls.getExchanges, reqType: 'GET', headers: {'Content-Type': 'application/json'});
    // リクエストメソッドにオブジェクトを投げる
    Map resData = await HttpReq.httpReq(reqData);
    return Exchange.resToExchanges(resData['srvResData']);
  }

  // 交換されたごほうびを消化
  static Future<void> digestionExchange(Exchange exchange) async {
    // リクエストを生成
    final reqData = Request(url: Urls.digestionExchange, reqType: 'PUT', pasParams: exchange.rewardExchangingId.toString(), headers: {'Content-Type': 'application/json'});
    // リクエストメソッドにオブジェクトを投げる
    await HttpReq.httpReq(reqData);
  }
}
