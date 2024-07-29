import 'package:flutter/material.dart';

import '../service/help_service.dart';
// import 'package:go_router/go_router.dart';
import '../../view/components/atoms/toast.dart';
import '../../../constant/messages.dart';
import '../../models/help_model.dart';
// import '../../view/components/atoms/dialog.dart';
// import '../error.dart';

class HelpReq {
  final BuildContext context;

  HelpReq({required this.context});

  // おてつだい取得
  Future<List<Help>> getHelpsHandler() async {
    try {
      return await HelpService.getHelps();
    } catch (error) {
      ToastUtil.show(message: "おわんないよ〜〜");
      return [];
    }
  }

  // おてつだい消化
  Future<int?> destionHelpHandler(Help help) async {
    try {
      int result = await HelpService.destionHelp(help);
      ToastUtil.show(message: Messages.destionHelpSuccess); // 報告に成功
      return result;
    } catch (error) {
      ToastUtil.show(message: Messages.destionHelpError);
      return null;
    }
  }

  
}
