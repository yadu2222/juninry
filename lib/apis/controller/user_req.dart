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
  Future<void> registerUser(Map<String, dynamic> registerUser) async {
    try {
      await UserService.registerUser(registerUser); // ログイン処理を待つ
      // ログイン完了後の処理
      GoRouter.of(context).go('/home');
      ToastUtil.show(message: Messages.registerSuccess);
    } catch (error) {
      ToastUtil.show(message: Messages.registerError);
    }
  }

  // ログイン
  Future<void> login(User? user) async {
    user = user ?? await User.getUser(); // 引数がnullであればuser情報をdbから取得
    try {
      await UserService.login(user); // ログイン処理を待つ
      // ログイン完了後の処理
      GoRouter.of(context).go('/home');
    } catch (error) {
      ToastUtil.show(message: Messages.loginError);
    }
  }

  // ユーザー情報取得
  Future<User> getUser() async {
    try{
      return UserService.getUser();
    }catch(error){
      ToastUtil.show(message: Messages.getUserError);
      return User.errorUser();
    }
  }
}
