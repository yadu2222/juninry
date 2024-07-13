import 'package:flutter/material.dart';

import '../service/class_service.dart';
// import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import '../../view/components/atoms/toast.dart';
import '../../../constant/messages.dart';
import '../../models/class_model.dart';
// import '../../view/components/atoms/dialog.dart';
import '../error.dart';

class ClassReq {
  final BuildContext context;

  ClassReq({required this.context});

  // クラス参加
  Future<void> joinClassHandler(String inviteCode) async {
    
    try {
      await ClassService.joinClass(inviteCode); // クラス参加処理を待つ
    }on PermittionError {
      handleException(ExceptionType.permittonError);
    } on JoinClassConflictException {
      handleException(ExceptionType.joinClassConflict);
    } catch (e) {
      ToastUtil.show(message: Messages.joinClassError); // 参加失敗メッセージ
    }
  }

  // クラス作成
  Future<Map<String, dynamic>> createClassHandler(String className) async {
    try {
      Class inviteClass = await ClassService.createClass(className); // クラス作成処理を待つ
      Map<String, dynamic> result = {'isCreate': true, 'classData': inviteClass};
      return result;
    } catch (error) {
      debugPrint(error.toString());
      ToastUtil.show(message: Messages.createClassError); // 参加失敗メッセージ
      return {'isCreate': false, 'class': null};
    }
  }

  // クラス招待コード再発行
  Future<Map<String, dynamic>> inviteClassHandler(String classUUID) async {
    try {
      Class inviteClass = await ClassService.inviteClass(classUUID); // 招待コード発行処理を待つ
      Map<String, dynamic> result = {'isCreate': true, 'classData': inviteClass};
      return result;
    } catch (error) {
      debugPrint(error.toString());
      ToastUtil.show(message: Messages.createClassError); // 参加失敗メッセージ
      return {'isCreate': false, 'class': null};
    }
  }

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
