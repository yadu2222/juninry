import 'package:flutter/material.dart';

import '../service/help_service.dart';
// import 'package:go_router/go_router.dart';
import '../../view/components/atoms/toast.dart';
import '../../../constant/messages.dart';
import '../../models/help_model.dart';
// import '../../view/components/atoms/dialog.dart';
import '../error.dart';

class HelpReq {
  final BuildContext context;

  HelpReq({required this.context});

  Future<List<Help>> getHelpsHandler() async {
    try {
      return await HelpService.getHelps();
    } catch (error) {
      ToastUtil.show(message:"おわんないよ〜〜");
      return [];
    }
  }
}
