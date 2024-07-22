import 'package:flutter/material.dart';
import 'dart:io';
import '../http_req.dart';
import '../../models/homework_model.dart';
import '../../constant/urls.dart';
import '../../models/req_model.dart';
import '../error.dart';
import 'package:http/http.dart' as http;

class HomeworkService {
  // 宿題を取得
  static Future<List<dynamic>> getHomeworks() async {
    // リクエストを生成
    final reqData = Request(
        url: Urls.getHomeworks,
        reqType: 'GET',
        headers: {'Content-Type': 'application/json'});
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
    return Homework.resToHomeworks(
        resData['srvResData'], 'homeworkLimit', true);
  }

  // 次の日の宿題を取得
  static Future<List<dynamic>> getNextdayHomeworks() async {
    // リクエストを生成
    final reqData = Request(
        url: Urls.getNextdayHomeworks,
        reqType: 'GET',
        headers: {'Content-Type': 'application/json'});
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
    return Homework.resToHomeworks(resData['srvResData'], 'className');
  }

  // 次の日の宿題を取得
  static Future<List<dynamic>> getHomeScreenHomework() async {
    errorHandling(http.Response response) {
      throw const SubmittionHomeworkError(); // 提出失敗したよ
    }

    // リクエストを生成
    final reqData = Request(
        url: Urls.getNextdayHomeworks,
        reqType: 'GET',
        headers: {'Content-Type': 'application/json'});
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
    return Homework.resToHomeworks(resData['srvResData'], null);
  }

  // 宿題を提出
  static Future<void> submittionHomework(
      String homeworkUUID, List<File> files) async {
    errorHandling(http.Response response) {
      throw const SubmittionHomeworkError(); // 提出失敗したよ
    }

    // bodyを加工
    Map<String, dynamic> body = {
      'homeworkUUID': homeworkUUID,
    };
    // リクエストを生成
    final reqData = Request(
        url: Urls.submittionHomework,
        reqType: 'MULTIPART',
        headers: {'Content-Type': 'multipart/form-data'},
        body: body,
        files: files,
        errorHandling: errorHandling);
    // リクエストメソッドにオブジェクトを投げる
    Map resData = await HttpReq.httpReq(reqData);
    // 宿題のデータがあれば
    try {
      if (resData["srvResData"] == null) {}
    } catch (e) {
      debugPrint(e.toString());
    }
    debugPrint(resData.toString());
    // 返す
  }

  // 提出ログを取得
  static Future<List<Map<DateTime, int>>> submissionLog(
      DateTime targetMonth) async {
    // リクエストを生成
    final reqData = Request(
        url: Urls.submissionLog,
        reqType: 'POST',
        headers: {'Content-Type': 'application/json'},
        body: {'targetMonth': targetMonth.toString()});

    // リクエストメソッドにオブジェクトを投げる
    Map resData = await HttpReq.httpReq(reqData);
    // 宿題のデータがあれば
    try {
      if (resData["srvResData"] == null) {
        return [];
      }
      // "srvResData"の内容を取得し、型を明示的に指定
      List<Map<String, dynamic>> srvResData =
          List<Map<String, dynamic>>.from(resData['srvResData']);

      // 新しい形式のリストを作成
      List<Map<DateTime, int>> formattedData = srvResData.map((data) {
        DateTime date = DateTime.parse(data['submissionDate']);
        int count = data['count'];
        return {date: count};
      }).toList();

      return formattedData;
    } catch (e) {
      debugPrint(e.toString());
    }
    // 返す
    return [];
  }
}
