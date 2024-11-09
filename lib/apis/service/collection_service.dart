import 'dart:convert';
import 'package:juninry/apis/error_handler.dart';
import 'package:juninry/models/collection_model.dart';

import '../http_req.dart';
import '../../models/help_model.dart';
import '../../constant/urls.dart';
import '../../models/req_model.dart';
// import 'package:http/http.dart' as http;
// import '../error.dart';

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

  static Future<List<Collection>> getNyariots() async{
    final reqData = Request(url: Urls.getNyariots, reqType: 'GET', headers: {'Content-Type': 'application/json'});
    final response = await HttpReq.httpReq(reqData);
    try {
      ErrorHandler.collectionErrorHandler(response);
    } catch (e) {
      rethrow;
    }
    return Collection.resNyariotToCollections(response);
  }
}
