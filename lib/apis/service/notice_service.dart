import 'package:flutter/material.dart';
import 'package:juninry/apis/error_handler.dart';
import 'package:juninry/models/student_model.dart';

import '../../models/req_model.dart';
import '../../constant/urls.dart';
import '../../models/quoted_notice_model.dart';
import '../../models/notice_model.dart';

import '../http_req.dart';

class NoticeService {
  static Future<List<Notice>> getNotices(List<String> classUUIDs, List<String> childrenUUIDs, int? readStatus) async {
    String queryParams = '?';

    classUUIDs.forEach((classUUID) {
      queryParams += 'classUUID[]=$classUUID&';
    });

    childrenUUIDs.forEach((childrenUUID) {
      queryParams += 'pupilUUID[]=$childrenUUID&';
    });

    if (readStatus != null) {
      queryParams += 'readStatus=$readStatus';
    }

    debugPrint("URL: " + Urls.getNotices + queryParams);
    // リクエストを生成
    final reqData = Request(url: Urls.getNotices + queryParams, reqType: 'GET', headers: {});
    // リクエストメソッドにオブジェクトを投げる
    final response = await HttpReq.httpReq(reqData);
    try {
      ErrorHandler.noticeErrorHandler(response);
    } catch (e) {
      rethrow;
    }
    return Notice.resToNotices(response);
  }

  // 既読処理
  static Future<bool> updateReadStatus(String noticeUuid) async {
    final reqData = Request(url: Urls.noticeRead + noticeUuid, reqType: 'POST', headers: {});
    final response = await HttpReq.httpReq(reqData);
    debugPrint(response.toString());
    try {
      ErrorHandler.noticeErrorHandler(response);
    } catch (e) {
      rethrow;
    }
    return true;
  }

  // 児童から見た既読状態取得
  static Future<List<Student>> getStudentReadStatus(String noticeUUID) async {
    final reqData = Request(url: Urls.noticeReadStatus + noticeUUID, reqType: 'GET', headers: {});
    final response = await HttpReq.httpReq(reqData);
    try {
      ErrorHandler.noticeErrorHandler(response);
    } catch (e) {
      rethrow;
    }
    return Student.resToStudents(response);
  }

  // お知らせの引用を取得
  static Future<QuotedNotice> getQuotedNotice(String noticeUuid) async {
    // リクエストのオブジェクトを生成
    final reqData = Request(url: Urls.noticeDetail + noticeUuid, reqType: 'GET', headers: {}); // HACK: 空のヘッダー定義しないとエラーでこける

    final response = await HttpReq.httpReq(reqData);
    try {
      ErrorHandler.noticeErrorHandler(response);
    } catch (e) {
      rethrow;
    }
    return QuotedNotice.resToQuotedNotice(response);
  }

  // お知らせの詳細を取得
  static Future<Notice> getNoticeDetail(String noticeUuid) async {
    // リクエストのオブジェクトを生成
    final reqData = Request(url: Urls.noticeDetail + noticeUuid, reqType: 'GET', headers: {}); // HACK: 空のヘッダー定義しないとエラーでこける
    final response = await HttpReq.httpReq(reqData);
    try {
      ErrorHandler.noticeErrorHandler(response);
    } catch (e) {
      rethrow;
    }
    return Notice.resToNotice(response);
  }

  // お知らせ登録
  static Future<void> registerNotice(Notice notice) async {
    final reqData = Request(url: Urls.noticeRegister, reqType: 'POST', body: {
      "noticeTitle": notice.noticeTitle,
      "noticeExplanatory": notice.noticeExplanatory,
      "classUUID": notice.classUUID,
      if (notice.quotedNoticeUUID != null) "quotedNoticeUUID": notice.quotedNoticeUUID
    }, headers: {
      'Content-Type': 'application/json'
    });
    final response = await HttpReq.httpReq(reqData);
    try {
      ErrorHandler.noticeErrorHandler(response);
    } catch (e) {
      rethrow;
    }
  }
}
