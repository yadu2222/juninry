import 'class_model.dart';

// 引用したお知らせの情報をまとめる
// セットでしか存在しない情報がバラバラなのが気に食わないため
class QuotedNotice {
  final String quotedNoticeUuid;
  final String quotedNoticeTitle;
  final Class quotedClassData;

  QuotedNotice({
    required this.quotedNoticeUuid,
    required this.quotedNoticeTitle,
    required this.quotedClassData,
  });
}

class DraftedNotice {
  String? noticeTitle;
  String? noticeExplanatory;
  Class? classData; //
  QuotedNotice? quotedNotice; // 引用しているお知らせ

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

  DraftedNotice({
    this.noticeTitle = "",
    this.noticeExplanatory = "",
    this.classData,
    this.quotedNotice,
  });
}
