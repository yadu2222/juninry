import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Notice {
  final String? noticeUUID;
  final String noticeTitle;
  final String? noticeExplanatory;
  final String? noticeDate;
  final String? userName;
  final String? className;
  final String classUUID;
  final String? quotedNoticeUUID;
  final int? readStatus;

// TODO :適用
// おしらせID	notice_uuid
// タイトル	notice_title
// 内容	notice_explanatory
// 日付	notice_date
// 投稿者ID	user_uuid
// クラスID	class_uuid
// おしらせID	notice_uuid
// ユーザーID	user_uuid
// 確認の有無 notice_reads

  Notice({
    this.noticeUUID,
    required this.noticeTitle,
    this.noticeExplanatory,
    this.noticeDate,
    this.userName,
    this.className,
    required this.classUUID,
    this.quotedNoticeUUID,
    this.readStatus,
  });

  static Notice errorNotice() {
    return Notice(
      noticeUUID: '',
      classUUID: '',
      noticeTitle: '',
      noticeDate: '',
      className: '',
      readStatus: 0,
    );
  }

  // 日付を4桁の月日に整形するメソッド
  static String formatDate(String date) {
    return DateFormat('MM.dd').format(DateTime.parse(date));
  }

  static List<Notice> resToNotices(List loadData) {
    try {
      return loadData.map((data) {
        return Notice(
          noticeUUID: data['noticeUUID'] as String?,
          classUUID: data['classUUID'] as String,
          noticeTitle: data['noticeTitle'] as String,
          noticeDate: formatDate(data['noticeDate'] ?? ''),
          className: data['className'] as String?,
          readStatus: data['readStatus'] as int?,
        );
      }).toList();
    } catch (e) {
      debugPrint('Error converting map to Notices: $e');
      return [errorNotice()];
    }
  }
}
