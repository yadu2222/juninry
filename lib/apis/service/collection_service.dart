// import 'dart:convert';
import 'package:juninry/apis/error_handler.dart';
import 'package:juninry/models/collection_model.dart';

import '../http_req.dart';
import '../../constant/urls.dart';
import '../../models/req_model.dart';
import 'dart:convert';

class CollectionService {
  static Future<List<Collection>> getItems() async {
    // リクエストを生成
    final reqData = Request(url: Urls.getItems, reqType: 'GET', headers: {'Content-Type': 'application/json'});
    // リクエストメソッドにオブジェクトを投げる
    final response = await HttpReq.httpReq(reqData);
    try {
      ErrorHandler.collectionErrorHandler(response); // エラーハンドリング
    } catch (e) {
      rethrow;
    }
    // 返す
    return Collection.resItemToCollections(response);
  }

  static Future<List<Collection>> getNyariots() async {
    final reqData = Request(url: Urls.getNyariots, reqType: 'GET', headers: {'Content-Type': 'application/json'});
    final response = await HttpReq.httpReq(reqData);
    try {
      ErrorHandler.collectionErrorHandler(response);
    } catch (e) {
      rethrow;
    }
    return Collection.resNyariotToCollections(response);
  }

  // スタンプの数を取得
  static Future<int> getStamps() async {
    final reqData = Request(url: Urls.getStamps, reqType: 'GET', headers: {'Content-Type': 'application/json'});
    final response = await HttpReq.httpReq(reqData);
    try {
      ErrorHandler.collectionErrorHandler(response);
    } catch (e) {
      rethrow;
    }
    final json = jsonDecode(response.body) as Map<String, dynamic>;
    return json['srvResData']['quantity'];
  }

  // ポイントでガチャを回す
  static Future<List<Collection>> pointGatya(int count) async {
    final reqData = Request(url: Urls.pointGatya, reqType: 'GET', headers: {'Content-Type': 'application/json'}, pasParams: count.toString());
    final response = await HttpReq.httpReq(reqData);
    try {
      ErrorHandler.collectionErrorHandler(response);
    } catch (e) {
      rethrow;
    }
    return Collection.resToGatyaResults(response);
  }

  // メインニャリオットを取得
  static Future<Collection> getMainNyariot() async{
    final reqData = Request(url: Urls.getNyariot, reqType: 'GET', headers: {'Content-Type': 'application/json'});
    final response = await HttpReq.httpReq(reqData);
    try {
      ErrorHandler.collectionErrorHandler(response);
    } catch (e) {
      rethrow;
    }
    return Collection.resNyariotToCollction(response);
  }

  // ニャリオットの空腹度を取得
  static Future<int> getNyariotHunger() async {
    final reqData = Request(url: Urls.getHungry, reqType: 'GET', headers: {'Content-Type': 'application/json'});
    final response = await HttpReq.httpReq(reqData);
    try {
      ErrorHandler.collectionErrorHandler(response);
    } catch (e) {
      rethrow;
    }
    final json = jsonDecode(response.body) as Map<String, dynamic>;
    return json['srvResData']['satityDegrees'];
  }
}
