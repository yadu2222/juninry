import 'package:flutter/material.dart';
import 'dart:io';
import '../http_req.dart';
import '../../models/homework_model.dart';
import '../../models/homework_submission_record.dart';
import '../../constant/urls.dart';
import '../../models/req_model.dart';
import '../../models/teaching_item_model.dart';
import '../../models/register_homework_model.dart';
import '../error.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart'; // 画像保存のために必要

class HomeworkService {
  // 宿題登録
  static Future<void> registerHomework(RegisterHomework registerHomework) async {
    Map<String, dynamic> body = RegisterHomework.toMap(registerHomework);
    // リクエストを生成
    final reqData = Request(url: Urls.registerHomework, reqType: 'POST', headers: {'Content-Type': 'application/json'}, body: body);
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

  // 教材を取得
  static Future<List<TeachingItem>> getTeachingItems(String classUUID) async {
    // リクエストを生成
    final reqData = Request(url: Urls.getTeachingItems, reqType: 'GET', headers: {'Content-Type': 'application/json'}, pasParams: classUUID);
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
    return TeachingItem.resToTeachingItem(resData['srvResData']);
  }

  // 1件の宿題を取得
  static Future<Homework?> getHomework(String homeworkUUID) async {
    // TODO:教員の場合と児童の場合で処理を分割
    // リクエストを生成
    final reqData = Request(url: Urls.getHomework, reqType: 'GET', headers: {'Content-Type': 'application/json'}, pasParams: homeworkUUID);
    // リクエストメソッドにオブジェクトを投げる
    Map resData = await HttpReq.httpReq(reqData);
    // 宿題のデータがあれば
    try {
      if (resData["srvResData"] == null) {
        return null;
      }
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
    debugPrint(resData.toString());
    // 返す
    return Homework.resToHomework(resData['srvResData']);
  }

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
    return Homework.resToHomeworks(resData['srvResData'], 'homeworkLimit', true);
  }

  // 次の日の宿題を取得
  static Future<List<dynamic>> getNextdayHomeworks() async {
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
    return Homework.resToHomeworks(resData['srvResData'], 'className');
  }

  // 次の日の宿題を取得
  static Future<List<dynamic>> getHomeScreenHomework() async {
    errorHandling(http.Response response) {
      throw SubmittionHomeworkError(); // 提出失敗したよ
    }

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
    return Homework.resToHomeworks(resData['srvResData'], null);
  }

  // 宿題を提出
  static Future<void> submittionHomework(String homeworkUUID, List<File> files) async {
    errorHandling(http.Response response) {
      throw SubmittionHomeworkError(); // 提出失敗したよ
    }

    // bodyを加工
    Map<String, dynamic> body = {
      'homeworkUUID': homeworkUUID,
    };
    // リクエストを生成
    final reqData = Request(url: Urls.submittionHomework, reqType: 'MULTIPART', headers: {'Content-Type': 'multipart/form-data'}, body: body, files: files, errorHandling: errorHandling);
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
  static Future<List<HomeworkSubmissionRecord>> submissionLog(DateTime targetMonth) async {
    // リクエストを生成
    final reqData = Request(
      url: Urls.submissionLog + targetMonth.toString(),
      reqType: 'GET',
      headers: {},
    );

    // リクエストメソッドにオブジェクトを投げる
    Map resData = await HttpReq.httpReq(reqData);
    // 宿題のデータがあれば
    try {
      if (resData["srvResData"] == null) {
        return [];
      }
      // 新しい形式のリストを作成
    } catch (e) {
      debugPrint(e.toString());
    }
    // 返す
    return HomeworkSubmissionRecord.resToHomeworkSubmissionRecords(resData['srvResData']);
  }

  // 宿題の画像を取得
  static Future<File?> getHomeworkImage(String homeworkUUID, String imageFileName) async {
    String url = "${Urls.getHomework}/$homeworkUUID/images";
    // リクエストを生成
    final reqData = Request(url: url, reqType: 'GET', headers: {'Content-Type': 'multipart/form-data'}, pasParams: imageFileName);
    // リクエストメソッドにオブジェクトを投げる
    http.Response resData = await HttpReq.imagesReq(reqData);
    // レスポンスデータを確認し、画像データがある場合は処理する
    try {
      // 画像データ（バイナリ）を取得
      final List<int> imageBytes = resData.bodyBytes;

      // 画像を保存する場所を取得
      final directory = await getApplicationDocumentsDirectory();
      final imagePath = "${directory.path}/$imageFileName";

      // 画像ファイルとして保存
      File imageFile = File(imagePath);
      await imageFile.writeAsBytes(imageBytes);

      // 保存した画像ファイルを返す
      return imageFile;
    } catch (e) {
      debugPrint('Error retrieving homework image: $e');
    }

    return null; // 画像が取得できなかった場合
  }
}
