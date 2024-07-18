import 'package:flutter/material.dart';

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
      noticeTitle: '',
      noticeDate: '',
      className: '',
      readStatus: 0,
    );
  }

  // 日付を月、日だけに整形するメソッド
  static String formatDate(String date) {
    DateTime dateTime = DateTime.parse(date);
    String month = dateTime.month.toString();
    String day = dateTime.day.toString();
    return '$month.$day';
  }

  static List<Notice> resToNotices(List loadData) {
    try {
      return loadData.map((data) {
        return Notice(
          noticeUUID: data['NoticeUuid'] ?? '',
          noticeTitle: data['NoticeTitle'] ?? '',
          noticeDate: formatDate(data['NoticeDate'] ?? ''),
          className: data['ClassName'] ?? '',
          readStatus: data['ReadStatus'] ?? 0,
        );
      }).toList();
    } catch (e) {
      debugPrint('Error converting map to Notices: $e');
      return [errorNotice()];
    }
  }
}
