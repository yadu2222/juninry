import 'class_model.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

// 引用しているお知らせの情報をまとめる
class QuotedNotice {
  String quotedNoticeUuid;
  String quotedNoticeTitle;
  Class quotedClass;

  QuotedNotice({
    required this.quotedNoticeUuid,
    required this.quotedNoticeTitle,
    required this.quotedClass,
  });

  static QuotedNotice errorQuotedNotice() {
    return QuotedNotice(
      quotedNoticeUuid: '',
      quotedNoticeTitle: '',
      quotedClass: Class(
        className: '',
        classUUID: '',
      ),
    );
  }

  static QuotedNotice resToQuotedNotice(http.Response response) {
    try {

      // レスポンスデータをjsonに変換
      Map json = jsonDecode(response.body) as Map<String, dynamic>;
      Map resData = json['srvResData'] as Map<String, dynamic>;
      
      return QuotedNotice(
        quotedNoticeUuid: resData['srvResData']['noticeUUID'],
        quotedNoticeTitle: resData['srvResData']['noticeTitle'],
        quotedClass: Class(
          className: resData['srvResData']['className'],
          classUUID: resData['srvResData']['classUUID'],
        ),
      );
    } catch (e) {
      debugPrint('Error converting map to QuotedNotice: $e');
      return errorQuotedNotice();
    }
  }
}
