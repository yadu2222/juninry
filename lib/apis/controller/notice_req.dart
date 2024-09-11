import 'package:flutter/material.dart';
import 'package:juninry/models/student_model.dart';

import '../../view/components/atoms/toast.dart';
import '../../../constant/messages.dart';
import '../../models/notice_model.dart';
import '../../models/notice_filters.dart';
import '../service/notice_service.dart';
import '../../models/quoted_notice_model.dart';

class NoticeReq {
  final BuildContext context;

  NoticeReq({required this.context});

  // 複数のお知らせを取得
  Future<List<Notice>> getNoticesHandler(
      {List<String> classUUIDs = const [], List<String> childrenUUIDs = const [], int? readStatus}) async {
    try {
      return await NoticeService.getNotices(classUUIDs,childrenUUIDs, readStatus);
    } catch (error) {
      debugPrint(error.toString());
      return [];
    }
  }

  // 既読情報を送信
  Future<bool> updateReadStatusHandler(String noticeUuid) async {
    try {
      return await NoticeService.updateReadStatus(noticeUuid);
    } catch (error) {
      debugPrint(error.toString());
      ToastUtil.show(message: Messages.defaultError); // 通信失敗メッセージ
      return false;
    }
  }

  // 生徒の既読状態を取得
  Future<List<Student>> getStudentReadStatusHandler(String noticeUUID) async {
    try {
      return await NoticeService.getStudentReadStatus(noticeUUID);
    } catch (error) {
      debugPrint(error.toString());
      return [];
    }
  }

  // 引用UUIDからお知らせを取得
  Future<QuotedNotice> fetchQuotedNoticeHandler(String noticeUuid) async {
    try {
      return NoticeService.getQuotedNotice(noticeUuid);
    } catch (error) {
      debugPrint(error.toString());
      ToastUtil.show(message: Messages.defaultError); // 通信失敗メッセージ
      return QuotedNotice.errorQuotedNotice();
    }
  }

  // お知らせ詳細
  Future<Notice> fetchNoticeDetailHandler(String noticeUuid) async {
    try {
      return NoticeService.getNoticeDetail(noticeUuid);
    } catch (error) {
      debugPrint(error.toString());
      ToastUtil.show(message: Messages.defaultError); // 参加失敗メッセージ
      return Notice.errorNotice();
    }
  }

  // お知らせ登録
  Future<bool> postNoticeHandler(Notice notice) async {
    try {
      // 入力チェック
      if (notice.noticeTitle == "" || notice.noticeExplanatory == "") {
        ToastUtil.show(message: Messages.inputError);
        return false;
      }

      // お知らせ登録
      await NoticeService.registerNotice(notice);

      return true;
    } catch (error) {
      debugPrint(error.toString());
      ToastUtil.show(message: Messages.postNoticeError); // 参加失敗メッセージ
      return false;
    }
  }


}
