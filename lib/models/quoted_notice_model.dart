import 'class_model.dart';
import 'dbcon.dart';

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
}
