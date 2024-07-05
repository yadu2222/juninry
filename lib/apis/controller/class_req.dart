import 'package:flutter/material.dart';

import '../service/class_service.dart';
// import 'package:go_router/go_router.dart';

import '../../view/components/atoms/toast.dart';
import '../../../constant/messages.dart';

class ClassReq {
  final BuildContext context;

  ClassReq({required this.context});

  // 宿題取得
  // 型こわすぎ
  Future<List<Map<String, dynamic>>> getClassmatesHandler() async {
    try {
      return await ClassService.getClassmates(); // 課題取得を待ち返却
    } catch (error) {
      debugPrint(error.toString());
      ToastUtil.show(message: Messages.getClassmates);
      return [];
    }
  }
}
