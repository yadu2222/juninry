import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
import '../../view/components/atoms/toast.dart';
import '../../../constant/messages.dart';
import '../service/ouchi_service.dart';
// import '../error.dart';

class OUCHIReq {
  final BuildContext context;
  OUCHIReq(this.context);

  // おうちを作成する
  // TODO:エラーハンドリング
  Future<String?> createOuchiHandler(String ouchiName) async {
    try {
      return await OUCHIService.createOuchi(ouchiName); // おうち作成処理を待つ
    } catch (error) {
      ToastUtil.show(message: Messages.createOuchiError); // 作成失敗メッセージ
      return null;
    }
  }

  // 現在のポイントを取得

  // お手伝いを追加

  // お手伝いを消化

  // お手伝いを削除

  // お手伝いを取得

  // ご褒美を追加

  // ご褒美を交換

  // ご褒美を削除

  // ご褒美を取得
}
