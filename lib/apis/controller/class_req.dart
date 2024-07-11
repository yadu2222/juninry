import 'package:flutter/material.dart';

import '../service/class_service.dart';
// import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import '../../view/components/atoms/toast.dart';
import '../../../constant/messages.dart';
import '../../view/components/atoms/dialog.dart';

class ClassReq {
  final BuildContext context;

  ClassReq({required this.context});

  // クラス参加
  Future<void> joinClassHandler(String inviteCode) async {
    try {
      // TODO:errorハンドリング
      // なんか拾えない；〜〜〜；
      Map<String, dynamic> errorHandling(http.Response response) {
        if (response.statusCode == 409) {
          ToastUtil.show(message: Messages.joinClassConflictError); // 参加失敗メッセージ
          return {'error': 'Request failed', 'status': response.statusCode, 'body': response.body};
        } else {
          throw Exception('クラス参加に失敗しました');
        }
      }

      String joinClass = await ClassService.joinClass(inviteCode, errorHandling); // クラス参加処理を待つ
      ToastUtil.show(message: '$joinClass${Messages.joinClassSuccess}'); // 参加成功メッセージ
    } catch (error) {
      debugPrint(error.toString());
      ToastUtil.show(message: Messages.joinClassError); // 参加失敗メッセージ
    }
  }

  // クラス作成
  Future<Map<String, dynamic>> createClassHandler(String className) async {
    try {
      String inviteCode = await ClassService.createClass(className); // クラス作成処理を待つ
      Map<String, dynamic> result = {'isCreate': true, 'inviteCode': inviteCode};
      return result;
    } catch (error) {
      debugPrint(error.toString());
      ToastUtil.show(message: Messages.createClassError); // 参加失敗メッセージ
      return {'isCreate': false};
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
