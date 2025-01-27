import 'package:flutter/material.dart';
import 'package:juninry/apis/controller/base_controller.dart';

import '../service/class_service.dart';
// import 'package:go_router/go_router.dart';
import '../../view/components/atoms/toast.dart';
import '../../../constant/messages.dart';
import '../../models/class_model.dart';
// import '../../view/components/atoms/dialog.dart';
import '../../constant/error.dart';

// baseControllerを継承することで共通のエラーハンドリングを一括化する
class ClassReq extends BaseController {
  ClassReq({required BuildContext super.context});

  // クラス参加
  Future<String?> joinClassHandler(String inviteCode, String? studentNum) async {
    try {
      // 継承したexcuteに渡す無名関数を宣言し、その中で処理を行う
      return await execute(() async {
        final result = ClassService.joinClass(inviteCode, studentNum);
        return result;
      });
    // excute内にないハンドリングを行う
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
