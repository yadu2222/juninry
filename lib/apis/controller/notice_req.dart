import 'package:flutter/material.dart';

import '../../models/notice_model.dart';
import '../service/notice_service.dart';
import 'package:go_router/go_router.dart';

import '../../view/components/atoms/toast.dart';
import '../../../constant/messages.dart';

class NoticeReq {
  final BuildContext context;

  NoticeReq({required this.context});

  // 複数のお知らせを取得
  Future<List<Notice>> getNotices() async {
    try {
      return await NoticeService.getNotices();
    } catch (error) {
      debugPrint(error.toString());
      ToastUtil.show(message: Messages.getUserError);
      return [Notice.errorNotice()];
    }
  }
}
