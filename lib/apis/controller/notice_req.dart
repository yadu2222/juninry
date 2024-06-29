import 'package:flutter/cupertino.dart';

import 'http_req.dart';
import '../../models/notice_model.dart';
import '../../constant/urls.dart';
import '../../models/req_model.dart';

class NoticeReq {
  // static Future<Notice> _toNotice(Map<dynamic, dynamic> data) async {
  //     return Notice(
  //       noticeUuid: data['notice_uuid'],
  //       noticeTitle: data['notice_title'],
  //       noticeExplanatory: data['notice_explanatory'],
  //       noticeDate: data['notice_'],

  //       selectedClass: Class(
  //         classUuid: data['class_uuid'],
  //         className: data['class_name'],
  //       ),
  //     );
  // }

  static Future<Map<String, dynamic>> fetchNoticeDetail(
      String noticeUuid) async {
    // リクエストのオブジェクトを生成
    final reqData = Request(
        url: Urls.getNoticeDetail(noticeUuid), reqType: 'GET', headers: {});

    debugPrint("リクエストURL: ${reqData.url}");

    // リクエストを送信してレスポンスを受け取る
    var response = await HttpReq.httpReq(reqData);

    debugPrint("リクエスト完了");

    // レスポンスを適切な型に変換する
    Map<String, dynamic> convertedResponse = response as Map<String, dynamic>;

    // デバッグ用にレスポンスを出力
    debugPrint("レスポンス: ${convertedResponse}");

    return convertedResponse;
  }
}
