import 'package:flutter/material.dart';
import 'package:juninry/apis/error_handler.dart';
import 'package:juninry/models/treasure_model.dart';
import '../http_req.dart';
import '../../models/reward_model.dart';
import '../../constant/urls.dart';
import '../../models/req_model.dart';
import '../../models/exchange_model.dart';
// import 'package:http/http.dart' as http;
// import '../error.dart';
import 'dart:convert';

class RewardService {
  // TODO:エラーハンドリング
  // ごほうび取得
  static Future<List<Reward>> getReward() async {
    // リクエストを生成
    final reqData = Request(
        url: Urls.getRewards,
        reqType: 'GET',
        headers: {'Content-Type': 'application/json'});
    // リクエストメソッドにオブジェクトを投げる
    final response = await HttpReq.httpReq(reqData);
    try {
      ErrorHandler.rewardErrorHandler(response);
    } catch (e) {
      rethrow;
    }
    // 返す
    return Reward.resToReward(response);
  }

  // ごほうび交換
  static Future<int> exchangeReward(Reward reward) async {
    // リクエストを生成
    final reqData = Request(
        url: Urls.exchangeReward,
        reqType: 'POST',
        body: {'rewardUUID': reward.rewardUuid},
        headers: {'Content-Type': 'application/json'});
    // リクエストメソッドにオブジェクトを投げる
    final response = await HttpReq.httpReq(reqData);
    try {
      ErrorHandler.rewardErrorHandler(response);
    } catch (e) {
      rethrow;
    }
    Map resData = jsonDecode(response.body) as Map<String, dynamic>;
    return resData['srvResData']['ouchiPoint'];
  }

  // ごほうび登録
  static Future<void> registerReward(Reward reward,
      [String? hardwareUuid]) async {
    // リクエストを生成
    final reqData = Request(
        url: Urls.registerReward,
        reqType: 'POST',
        body: Reward.rewardToMap(reward),
        headers: {'Content-Type': 'application/json'});
    // リクエストメソッドにオブジェクトを投げる
    final response = await HttpReq.httpReq(reqData);
    try {
      ErrorHandler.rewardErrorHandler(response);
    } catch (e) {
      rethrow;
    }
  }

  // 交換されたごほうびを取得
  static Future<List<Exchange>> getExchange() async {
    // リクエストを生成
    final reqData = Request(
        url: Urls.getExchanges,
        reqType: 'GET',
        headers: {'Content-Type': 'application/json'});
    // リクエストメソッドにオブジェクトを投げる
    final response = await HttpReq.httpReq(reqData);
    try {
      ErrorHandler.rewardErrorHandler(response);
    } catch (e) {
      rethrow;
    }
    return Exchange.resToExchanges(response);
  }

  // 交換されたごほうびを消化
  static Future<void> digestionExchange(Exchange exchange) async {
    // リクエストを生成
    final reqData = Request(
        url: Urls.digestionExchange,
        reqType: 'PUT',
        pasParams: exchange.rewardExchangingId.toString(),
        headers: {'Content-Type': 'application/json'});
    // リクエストメソッドにオブジェクトを投げる
    final response = await HttpReq.httpReq(reqData);
    try {
      ErrorHandler.rewardErrorHandler(response);
    } catch (e) {
      rethrow;
    }
  }

  // ポイントを追加する
  static Future<int> addPointBox(String boxUuid, int point) async {
    // リクエストを生成
    final reqData = Request(
        url: Urls.addPoint + boxUuid,
        reqType: 'PUT',
        body: {'addPoint': point},
        headers: {'Content-Type': 'application/json'});
    // リクエストメソッドにオブジェクトを投げる
    final response = await HttpReq.httpReq(reqData);

    try {
      ErrorHandler.rewardErrorHandler(response);
    } catch (e) {
      rethrow;
    }
    Map resData = jsonDecode(response.body) as Map<String, dynamic>;
    return resData['srvResData']['depositPoint'];
  }

  static Future<List<Treasure>> getTreasure() async {
    // リクエストを生成
    final reqData = Request(url: Urls.getTreasure, reqType: 'GET', headers: {});
    debugPrint("リクエストを送るよ");
    // リクエストメソッドにオブジェクトを投げる
    final response = await HttpReq.httpReq(reqData);
    try {
      ErrorHandler.rewardErrorHandler(response);
      return Treasure.resToTreasures(response);
    } catch (e) {
      rethrow;
    }
  }

  static Future<int> toggleBoxLock(String boxUuid) async {
    // リクエストを生成
    final reqData = Request(
        url: Urls.toggleBoxLock + boxUuid,
        reqType: 'PUT',
        headers: {'Content-Type': 'application/json'});
    // リクエストメソッドにオブジェクトを投げる
    final response = await HttpReq.httpReq(reqData);
    try {
      ErrorHandler.rewardErrorHandler(response);
    } catch (e) {
      rethrow;
    }
    Map resData = jsonDecode(response.body) as Map<String, dynamic>;
    return resData['srvResData']['boxStatus'];
  }
}
