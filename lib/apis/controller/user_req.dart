import 'package:flutter/material.dart';

import '../../models/user_model.dart';
import '../service/user_service.dart';
import 'package:go_router/go_router.dart';

class UserReq {
  final BuildContext context;

  UserReq({required this.context});

  // ユーザー登録
  Future<void> registerUser(Map<String, dynamic> registerUser) async {
    // final userData = {
    //   "userName": "test teacher",
    //   "userTypeId": 1,
    //   "mailAddress": "test-teacher@gmail.com",
    //   "password": "C@tt",
    // };

    print(registerUser);

    try {
      await UserService.registerUser(registerUser); // ログイン処理を待つ
      // ログイン完了後の処理
      GoRouter.of(context).go('/home');
    } catch (error) {
      // エラーハンドリング
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
      // エラーハンドリング
    }
  }

  // ユーザー情報取得
  Future<User> getUser() async {
    return UserService.getUser();
  }
}
