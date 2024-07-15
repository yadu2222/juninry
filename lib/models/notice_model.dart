class Notice {
  final String? noticeUUID;
  final String noticeTitle;
  final String? noticeExplanatory;
  final String? noticeDate;
  final String? userName;
  final String? className;
  final String classUUID;
  final String? quotedNoticeUUID;
  final int? noticeRead;

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
    this.noticeRead,
  });
}
