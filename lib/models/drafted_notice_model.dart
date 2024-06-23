import 'class_model.dart';
import 'dbcon.dart';

// 引用したお知らせの情報をまとめる
// セットでしか存在しない情報がバラバラなのが気に食わないため
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

class DraftedNotice {
  int? noticeId;
  String? noticeTitle;
  String? noticeExplanatory;
  Class? selectedClass; // 下書きクラス
  QuotedNotice? quotedNotice; // 引用しているお知らせ

  DraftedNotice({
    this.noticeId,
    this.noticeTitle,
    this.noticeExplanatory,
    this.selectedClass,
    this.quotedNotice,
  });

// TODO: データベースの構造がクソきもいのでマシにするために引用テーブルを作ると、
// クラスにバインドする時に、引用UUIDで引用テーブルに問い合わせ、
// 出力されたMapを引用クラスにし、それを下書きクラスに反映させる必要があるけど、
// これめんどくさい
  static DraftedNotice toDraftedNotice(Map loadedData) {
    try {
      return DraftedNotice(
        noticeId: loadedData['notice_id'],
        noticeTitle: loadedData['noticeTitle'],
        noticeExplanatory: loadedData['noticeExplanatory'],
        selectedClass: Class(
          classUuid: loadedData['class_uuid'],
          className: loadedData['class_name'],
        ),
        quotedNotice: QuotedNotice(
          quotedNoticeUuid: loadedData['quoted_notice_uuid'],
          quotedNoticeTitle: loadedData['quoted_notice_title'],
          quotedClass: Class(
            classUuid: loadedData['quoted_class_uuid'],
            className: loadedData['quoted_class_name'],
          ),
        ),
      );
    } catch (e) {
      return DraftedNotice();
    }
  }

  // Mapに変換
  static Map<String, dynamic> _toMap(DraftedNotice data) {
    return {
      'notice_id': data.noticeId,
      'notice_title': data.noticeTitle,
      'notice_explanatory': data.noticeExplanatory,
      'class_uuid': data.selectedClass?.classUuid,
      'class_name': data.selectedClass?.className,
      'quoted_notice_uuid': data.quotedNotice?.quotedNoticeUuid,
      'quoted_notice_title': data.quotedNotice?.quotedNoticeTitle,
      'quoted_class_uuid': data.quotedNotice?.quotedClass.classUuid,
      'quoted_class_name': data.quotedNotice?.quotedClass.className,
    };
  }

  // 送られてきたデータが既存データか確認し、上書きか新規登録を行う
  static Future<bool> saveDraftedNotice(DraftedNotice draftedNoticeData) async {
    Map<String, dynamic> row = _toMap(draftedNoticeData);
    // IDはDBで生成されるため存在によって分岐できる
    if (row['notice_id'] != null) {
      return await updateDraftedNotice(row);
    } else {
      return await insertDraftedNotice(row);
    }
  }

  // SQLiteに新規保存 保存できたらtrue
  static Future<bool> insertDraftedNotice(Map<String, dynamic> row) async {
    var result = await DatabaseHelper.insert("drafted_notices", row);
    return result == 1;
  }

  // SQLiteに上書き 保存できたらtrue
  static Future<bool> updateDraftedNotice(Map<String, dynamic> row) async {
    var result = await DatabaseHelper.update(
        "drafted_notices", "notice_id", row, row['notice_id'].toString());
    return result == 1;
  }

  // SQLiteから削除 保存できたらtrue
  static Future<bool> deleteDraftedNotice(int noticeId) async {
    var result = await DatabaseHelper.delete(
        "drafted_notices", "notice_id", noticeId.toString());
    return result == 1;
  }
}
