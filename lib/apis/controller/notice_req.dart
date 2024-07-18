import 'package:flutter/material.dart';


// import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import '../../view/components/atoms/toast.dart';
import '../../../constant/messages.dart';
import '../../models/class_model.dart';
import '../../models/notice_model.dart';
import '../service/notice_service.dart';
import '../error.dart';
import '../../models/quoted_notice_model.dart';

class NoticeReq {
  final BuildContext context;

  NoticeReq({required this.context});


  // 複数のお知らせを取得
  Future<List<Notice>> getNotices() async {
      return await NoticeService.getNotices();
}

  Future<QuotedNotice> fetchQuotedNotice(String noticeUuid) async {
    try {
      return NoticeService.getQuotedNotice(noticeUuid);
    } catch (error) {
      debugPrint(error.toString());
      ToastUtil.show(message: Messages.joinClassError); // 参加失敗メッセージ
      return QuotedNotice.errorQuotedNotice();
    }
  }

  Future<bool> postNotice(Notice notice) async {
    try {
      // 入力チェック
      if (notice.noticeTitle == "" || notice.noticeExplanatory == "") {
        ToastUtil.show(message: Messages.inputError);
        return false;
      }

      // お知らせ登録
      await NoticeService.registerNotice(notice);

      ToastUtil.show(message: Messages.postNoticeSuccess); // 参加成功メッセージ
      return true;
    } catch (error) {
      debugPrint(error.toString());
      ToastUtil.show(message: Messages.postNoticeError); // 参加失敗メッセージ
      return false;
    }

  }
}
