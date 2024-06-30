import 'class_model.dart';
import 'dbcon.dart';
import 'package:flutter/material.dart';

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
      quotedClass: Class.errorClass(),
    );
  }

  static QuotedNotice resToQuotedNotice(Map resData) {
    try {
      return QuotedNotice(
        quotedNoticeUuid: resData['srvResData']['noticeUuid'],
        quotedNoticeTitle: resData['srvResData']['noticeTitle'],
        quotedClass: Class.resToClass(resData),
      );
    } catch (e) {
      debugPrint('Error converting map to QuotedNotice: $e');
      return errorQuotedNotice();
    }
  }
}
