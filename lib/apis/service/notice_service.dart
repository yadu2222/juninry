import 'package:flutter/material.dart';
import 'package:juninry/models/notice_filters.dart';
import 'package:juninry/models/student_model.dart';

import '../../models/req_model.dart';
import '../../constant/urls.dart';
import '../../models/quoted_notice_model.dart';
import '../../models/notice_model.dart';

import 'package:http/http.dart' as http;
import '../http_req.dart';
import '../error.dart';

class NoticeService {
  static Future<List<Notice>> getNotices(
      List<String> classUUIDs, List<String> childrenUUIDs, int? readStatus) async {
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
    try {
      // リクエストを生成
      final reqData = Request(
          url: Urls.getNotices + queryParams, reqType: 'GET', headers: {});
      // リクエストメソッドにオブジェクトを投げる
      Map resData = await HttpReq.httpReq(reqData);

      List<Notice> notices = [];
      if (resData['srvResData']['notices'] == null) {
        // 表示すべきお知らせがない
        return notices;
      }
      for (Map<String, dynamic> notice in resData['srvResData']['notices']) {
        notices.add(Notice.resToNotice(notice));
      }

      return notices;

      // 通知リストを返す
      // return Notice.resToNotices(resData['srvResData']['notices']);
    } catch (e) {
      print("じつはよ、、例外がでてるんだ");
      print(e.toString());
      // エラーメッセージを出力
      // エラーが発生した場合にエラーメッセージをリストで返す
      return [];
    }
  }

  static Future<bool> updateReadStatus(String noticeUuid) async {
    final reqData = Request(
        url: Urls.noticeRead + noticeUuid, reqType: 'POST', headers: {});
    Map result = await HttpReq.httpReq(reqData);
    debugPrint(result.toString());
    return true;
  }

  static Future<List<Student>> getStudentReadStatus(String noticeUUID) async {
    final reqData = Request(
        url: Urls.noticeReadStatus + noticeUUID, reqType: 'GET', headers: {});
    Map result = await HttpReq.httpReq(reqData);
    List<Student> students = [];
    for (Map<String, dynamic> student in result['srvResData']) {
      students.add(Student.resToStudent(student));
    }

    return students;
  }

  static Future<QuotedNotice> getQuotedNotice(String noticeUuid) async {
    // リクエストのオブジェクトを生成
    final reqData = Request(
        url: Urls.noticeDetail + noticeUuid,
        reqType: 'GET',
        headers: {}); // HACK: 空のヘッダー定義しないとエラーでこける

    Map resData = await HttpReq.httpReq(reqData);
    return QuotedNotice.resToQuotedNotice(resData);
  }

  static Future<Notice> getNoticeDetail(String noticeUuid) async {
    // リクエストのオブジェクトを生成
    final reqData = Request(
        url: Urls.noticeDetail + noticeUuid,
        reqType: 'GET',
        headers: {}); // HACK: 空のヘッダー定義しないとエラーでこける

    Map resData = await HttpReq.httpReq(reqData);
    debugPrint("getNoticeDetail: $resData");
    return Notice.resToNotice(resData['srvResData']);
  }

  static Future<void> registerNotice(Notice notice) async {
    final reqData = Request(url: Urls.noticeRegister, reqType: 'POST', body: {
      "noticeTitle": notice.noticeTitle,
      "noticeExplanatory": notice.noticeExplanatory,
      "classUUID": notice.classUUID,
      if (notice.quotedNoticeUUID != null)
        "quotedNoticeUUID": notice.quotedNoticeUUID
    }, headers: {
      'Content-Type': 'application/json'
    });
    await HttpReq.httpReq(reqData);
  }

}
