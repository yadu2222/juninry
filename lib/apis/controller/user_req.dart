import 'package:flutter/material.dart';

import '../../models/user_model.dart';
import '../service/user_service.dart';
import 'package:go_router/go_router.dart';

import '../../view/components/atoms/toast.dart';
import '../../../constant/messages.dart';

class UserReq {
  final BuildContext context;

  UserReq({required this.context});

  // ユーザー登録
  Future<void> registerUserHandler(Map<String, dynamic> registerUser) async {
    try {
      await UserService.registerUser(registerUser); // ログイン処理を待つ
      // ログイン完了後の処理
      GoRouter.of(context).go('/home');
      ToastUtil.show(message: Messages.registerSuccess);  // 登録成功メッセージ
    } catch (error) {
      ToastUtil.show(message: Messages.registerError);  // 登録失敗メッセージ
    }
  }

  // ログイン
  Future<void> loginHandler(User? user) async {
    user = user ?? await User.getUser(); // 引数がnullであればuser情報をdbから取得
    try {
      await UserService.login(user); // ログイン処理を待つ
      ToastUtil.show(message: Messages.loginSuccess); // ログイン成功メッセージ
      // ログイン完了後の処理
      GoRouter.of(context).go('/home');
    } catch (error) {
      ToastUtil.show(message: Messages.loginError);  // ログイン失敗メッセージ
    }
  }

  // ユーザー情報取得
  Future<User> getUserHandler() async {
    try{
      return UserService.getUser();
    }catch(error){
      ToastUtil.show(message: Messages.getUserError);
      return User.errorUser();    // 取得エラー
    }
  }
}
