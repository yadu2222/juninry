import 'package:flutter/material.dart';

import '../../models/req_model.dart';
import '../../constant/urls.dart';
import '../../models/quoted_notice_model.dart';
import '../../models/notice_model.dart';
import 'package:http/http.dart' as http;
import '../error.dart';
import '../http_req.dart';

class NoticeService {
  static Future<List<Notice>> getNotices() async {
    try {
      // リクエストを生成
      final reqData = Request(
          url: Urls.getNotices,
          reqType: 'GET',
          headers: {'Content-Type': 'application/json'});
      // リクエストメソッドにオブジェクトを投げる
      Map resData = await HttpReq.httpReq(reqData);

      List<Notice> notices = [];
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
    debugPrint("既読処理しようとしてます");
    final reqData = Request(
        url: Urls.noticeRead + noticeUuid,
        reqType: 'POST',
        headers: {});
    Map result = await HttpReq.httpReq(reqData);
    debugPrint(result.toString());
    return true;
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
