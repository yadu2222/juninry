import 'package:flutter/material.dart';
import 'dart:io';
import '../http_req.dart';
import '../../models/homework_model.dart';
import '../../constant/urls.dart';
import '../../models/req_model.dart';


class HomeworkService {
  // 宿題を取得
  static Future<List<dynamic>> getHomeworks() async {
    // リクエストを生成
    final reqData = Request(url: Urls.getHomeworks, reqType: 'GET', headers: {'Content-Type': 'application/json'});
    // リクエストメソッドにオブジェクトを投げる
    Map resData = await HttpReq.httpReq(reqData);
    // 宿題のデータがあれば
    try {
      if (resData["srvResData"] == null) {
        return [];
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    debugPrint(resData.toString());
    // 返す
    return Homework.resToHomeworks(resData['srvResData'], 'homeworkLimit',true);
  }

  // 次の日の宿題を取得
  static Future<List<dynamic>>  getNextdayHomeworks() async {
    // リクエストを生成
    final reqData = Request(url: Urls.getNextdayHomeworks, reqType: 'GET', headers: {'Content-Type': 'application/json'});
    // リクエストメソッドにオブジェクトを投げる
    Map resData = await HttpReq.httpReq(reqData);
    // 宿題のデータがあれば
    try{
      if (resData["srvResData"] == null) {
        return [];
      }
    }catch(e){
      debugPrint(e.toString());
    }
    debugPrint(resData.toString());
    // 返す
    return Homework.resToHomeworks(resData['srvResData'], 'className');
  }

  // 次の日の宿題を取得
  static Future<List<dynamic>> getHomeScreenHomework() async {
    // リクエストを生成
    final reqData = Request(url: Urls.getNextdayHomeworks, reqType: 'GET', headers: {'Content-Type': 'application/json'});
    // リクエストメソッドにオブジェクトを投げる
    Map resData = await HttpReq.httpReq(reqData);
    // 宿題のデータがあれば
    try {
      if (resData["srvResData"] == null) {
        return [];
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    debugPrint(resData.toString());
    // 返す
    return Homework.resToHomeworks(resData['srvResData'],null);
  }

  // 宿題を提出
  static Future<void> submittionHomework(String homeworkUUID,List<File> files) async {

    // bodyを加工
    Map<String, dynamic> body = {
      'homeworkUUID': homeworkUUID,
    };
    // リクエストを生成
    final reqData = Request(url: Urls.submittionHomework, reqType: 'MULTIPART', headers: {'Content-Type': 'multipart/form-data'}, body: body, files: files);
    // リクエストメソッドにオブジェクトを投げる
    Map resData = await HttpReq.httpReq(reqData);
    // 宿題のデータがあれば
    try {
      if (resData["srvResData"] == null) {

      }
    } catch (e) {
      debugPrint(e.toString());
    }
    debugPrint(resData.toString());
    // 返す
  }

  // 宿題提出ログを取得
  
}
