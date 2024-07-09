import 'package:flutter/material.dart';

class Notice {
  final String noticeUUID;
  final String noticeTitle;
  final String noticeDate;
  final String userName;
  final String className;
  final String classUUID;
  final String readStatus;
  final String noticeExplanatory;

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

static Notice errorNotice() {
    return Notice(noticeUUID: 'noticeUUID', userName: 'userName', classUUID: 'classUUID', noticeDate: 'noticeDate', className: 'className', noticeTitle: 'noticeTitle', readStatus: 'readStatus', noticeExplanatory: 'noticeExplanatory');
  }


static Notice resToNotice(Map loadData) {
    try {
      return Notice(
          noticeUUID: loadData['noticeUUID'],
          noticeTitle: loadData['noticeTitle'],
          noticeDate: loadData['noticeDate'],
          userName: loadData['userName'],
          className: loadData['className'],
          classUUID: loadData['classUUID'],
          readStatus: loadData['readStatus'],
          noticeExplanatory: loadData['noticeExplanatory']
          );
    } catch (e) {
      debugPrint('Error converting map to User: $e');
      return errorNotice();
    }
  }

  Notice({
    required this.noticeUUID,
    required this.userName,
    required this.classUUID,
    required this.noticeDate,
    required this.className,
    required this.noticeTitle,
    required this.readStatus, 
    required this.noticeExplanatory
  });
}
