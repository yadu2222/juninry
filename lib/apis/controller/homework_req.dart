import 'package:flutter/material.dart';

// import '../../models/homework_model.dart';
import '../service/homework_service.dart';
// import 'package:go_router/go_router.dart';

import '../../view/components/atoms/toast.dart';
import '../../../constant/messages.dart';

class HomeworkReq {
  final BuildContext context;

  HomeworkReq({required this.context});

  // 宿題取得
  // 型こわすぎ
  Future<List<Map<String, dynamic>>> getHomeworks() async {
    try {
      return await HomeworkService.getHomeworks(); // 課題取得を待ち返却
    } catch (error) {
      debugPrint(error.toString());
      ToastUtil.show(message: Messages.getHomeworkError);
      return [];
    }
  }
}
