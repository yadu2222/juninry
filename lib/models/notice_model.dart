class Notice {
  final String noticeDate;
  final String className;
  final String noticeTitle;
  final String noticeExplanatory;
  final String noticeRead;

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
    required this.noticeDate,
    required this.className,
    required this.noticeTitle,
    required this.noticeExplanatory,
    required this.noticeRead,
  });
}
