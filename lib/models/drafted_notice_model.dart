import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:juninry/constant/sample_data.dart';

import 'class_model.dart';
import 'quoted_notice_model.dart';
import 'dbcon.dart';

// 下書きされたお知らせの情報をまとめる
// 新たなお知らせであればお知らせIDを発行する
class DraftedNotice {
  int? draftedNoticeId; //下書きのID
  String? draftedNoticeDate;
  String? draftedNoticeTitle;
  String? draftedNoticeExplanatory;
  Class? selectedClass; // 下書きクラス
  String? quotedNoticeUuid; // 引用しているお知らせ

  DraftedNotice({
    this.draftedNoticeId, // お知らせIDがあれば送れる
    this.draftedNoticeDate,
    this.draftedNoticeTitle,
    this.draftedNoticeExplanatory,
    this.selectedClass,
    this.quotedNoticeUuid,
  });

  // MapからDraftedNoticeに変換
  static Future<DraftedNotice> toDraftedNotice(Map loadedData) async {
    try {
      return DraftedNotice(
          draftedNoticeId: loadedData['notice_id'],
          draftedNoticeDate: loadedData['notice_date'],
          draftedNoticeTitle: loadedData['notice_title'],
          draftedNoticeExplanatory: loadedData['notice_explanatory'],
          selectedClass: Class(
            classUuid: loadedData['class_uuid'],
            className: loadedData['class_name'],
          ),
          quotedNoticeUuid: loadedData['quoted_notice_uuid']);
    } catch (e) {
      return DraftedNotice();
    }
  }

  // Mapに変換
  static Map<String, dynamic> _toMap(DraftedNotice data) {
    return {
      'notice_id': data.draftedNoticeId,
      'notice_date': data.draftedNoticeDate,
      'notice_title': data.draftedNoticeTitle,
      'notice_explanatory': data.draftedNoticeExplanatory,
      'class_uuid': data.selectedClass?.classUuid,
      'class_name': data.selectedClass?.className,
      'quoted_notice_uuid': data.quotedNoticeUuid,
    };
  }

  // 送られてきたデータが既存データか確認し、上書きか新規登録を行う
  static Future<int> saveDraftedNotice(DraftedNotice draftedNoticeData) async {
    Map<String, dynamic> row = _toMap(draftedNoticeData);

    if (draftedNoticeData.draftedNoticeId != null &&
        await DatabaseHelper.queryExists(
            "drafted_notices", "notice_id", row['notice_id'].toString())) {
      return await updateDraftedNotice(row);
    } else {
      return await insertDraftedNotice(row);
    }
  }

  // SQLiteに新規保存 保存できたらtrue
  static Future<int> insertDraftedNotice(Map<String, dynamic> row) async {
    var result = await DatabaseHelper.insert("drafted_notices", row);
    debugPrint(result.toString());
    return result;
  }

  // SQLiteに上書き 保存できたらtrue
  static Future<int> updateDraftedNotice(Map<String, dynamic> row) async {
    var result = await DatabaseHelper.update(
        "drafted_notices", "notice_id", row, row['notice_id'].toString());
    debugPrint(result.toString());
    return result;
  }

  // SQLiteから削除 保存できたらtrue
  static Future<bool> deleteDraftedNotice(int noticeId) async {
    var result = await DatabaseHelper.delete(
        "drafted_notices", "notice_id", noticeId.toString());
    return result == 1;
  }

  // 全件取得
  static Future<List<DraftedNotice>> getAllDraftedNotices() async {
    debugPrint("全件表示");
    List<Map<String, dynamic>> result =
        await DatabaseHelper.queryAllRows("drafted_notices");
    var draftedNotices = <DraftedNotice>[]; // DraftedNotices
    for (int i = 0; i < result.length; i++) {
      draftedNotices.add(await DraftedNotice.toDraftedNotice(result[i]));
    }
    return draftedNotices;
  }

  // 1件取得
  static Future<DraftedNotice> getDraftedNotice(int noticeId) async {
    Map<String, dynamic> result = await DatabaseHelper.queryRow(
        "drafted_notices", "notice_id", noticeId.toString());
    debugPrint(result.toString());
    return await DraftedNotice.toDraftedNotice(result);
  }
}
