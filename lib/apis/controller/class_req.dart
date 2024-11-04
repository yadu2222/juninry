import 'package:flutter/material.dart';

import '../service/class_service.dart';
// import 'package:go_router/go_router.dart';
import '../../view/components/atoms/toast.dart';
import '../../../constant/messages.dart';
import '../../models/class_model.dart';
// import '../../view/components/atoms/dialog.dart';
import '../../constant/error.dart';

class ClassReq {
  final BuildContext context;

  ClassReq({required this.context});

  // クラス参加
  Future<String?> joinClassHandler(String inviteCode,String? studentNum) async {
    try {
      return await ClassService.joinClass(inviteCode,studentNum); // クラス参加処理を待つ
    } on PermittionError {
      handleException(ExceptionType.permittonError);
      return null;
    } on JoinClassConflictException {
      handleException(ExceptionType.joinClassConflict);
      return null;
    } catch (e) {
      ToastUtil.show(message: Messages.joinClassError); // 参加失敗メッセージ
      return null;
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

  Future<List<Class>> getClassesHandler() async {
    try {
      return await ClassService.getClasses(); // クラス一覧を取得
    } catch (error) {
      debugPrint(error.toString());
      ToastUtil.show(message: Messages.getClasses);
      return [];
    }
  }
}
