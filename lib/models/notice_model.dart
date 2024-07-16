import 'package:flutter/material.dart';

class Notice {
  final String noticeUUID;
  final String noticeTitle;
  final String noticeDate;
  final String className;
  final int readStatus;

  Notice({
    required this.noticeUUID,
    required this.noticeDate,
    required this.className,
    required this.noticeTitle,
    required this.readStatus,
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
