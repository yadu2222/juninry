import 'package:flutter/material.dart';

// import 'package:go_router/go_router.dart';
import '../../view/components/atoms/toast.dart';
import '../../../constant/messages.dart';
import '../../models/notice_model.dart';
import '../service/notice_service.dart';

import '../../models/quoted_notice_model.dart';

class NoticeReq {
  final BuildContext context;

  NoticeReq({required this.context});

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

      return true;
    } catch (error) {
      debugPrint(error.toString());
      ToastUtil.show(message: Messages.postNoticeError); // 参加失敗メッセージ
      return false;
    }
  }
}
