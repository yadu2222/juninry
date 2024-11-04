import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
import '../../view/components/atoms/toast.dart';
import '../../../constant/messages.dart';
import '../service/ouchi_service.dart';
// import '../error.dart';
import '../../models/ouchi_model.dart';

class OUCHIReq {
  final BuildContext context;
  OUCHIReq(this.context);

  // おうちを作成する
  // TODO:エラーハンドリング
  Future<Ouchi?> createOuchiHandler(String ouchiName) async {
    try {
      return await OUCHIService.createOuchi(ouchiName); // おうち作成処理を待つ
    } catch (error) {
      ToastUtil.show(message: Messages.createOuchiError); // 作成失敗メッセージ
      return null;
    }
  }

  // // lineと連携
  //  Future<String?> friendLineAccount() async {
  //   try {
  //     return await OUCHIService.friendLineAccount(); // おうち作成処理を待つ
  //   } catch (error) {
  //     ToastUtil.show(message: Messages.createOuchiError); // 作成失敗メッセージ
  //     return null;
  //   }
  // }

  // おうちメンバーを取得
  Future<Ouchi> getOuchiMembersHandler() async {
    try {
      return await OUCHIService.getOuchiInfo(); // メンバーを取得
    } catch (error) {
      ToastUtil.show(message: Messages.createOuchiError); // 作成失敗メッセージ
      return Ouchi.errorOuchi();
    }
  }
}
