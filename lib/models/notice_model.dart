import 'package:flutter/material.dart';

class Notice {
  final String noticeUUID;
  final String noticeTitle;
  final String noticeDate;
  final String className;
  final String readStatus;

  static Notice errorNotice() {
    return Notice(
      noticeUUID: '',
      noticeTitle: '',
      noticeDate: '',
      className: '',
      readStatus: '',
    );
  }

  static List<Notice> resToNotices(List<Map<String, dynamic>> loadData) {
    try {
      return loadData.map((data) {
        return Notice(
          noticeUUID: data['noticeUUID'] ?? '',
          noticeTitle: data['noticeTitle'] ?? '',
          noticeDate: data['noticeDate'] ?? '',
          className: data['className'] ?? '',
          readStatus: data['readStatus'] ?? '',
        );
      }).toList();
    } catch (e) {
      debugPrint('Error converting map to Notices: $e');
      return [errorNotice()];
    }
  }

  Notice({
    required this.noticeUUID,
    required this.noticeDate,
    required this.className,
    required this.noticeTitle,
    required this.readStatus,
  });
}
