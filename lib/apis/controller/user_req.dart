import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../constant/messages.dart';
import '../../constant/error.dart';
// view
import '../../view/components/atoms/toast.dart';
// model
import '../../models/user_model.dart';
// service
import '../service/user_service.dart';

class UserReq {
  final BuildContext context;

  UserReq({required this.context});

  // ユーザー登録
  Future<void> registerUserHandler(Map<String, dynamic> registerUser, VoidCallback updRouter) async {
    try {
      await UserService.registerUser(registerUser); // ログイン処理を待つ
      // ルーター再取得
      updRouter();
      // ログイン完了後の処理
      GoRouter.of(context).go('/home');
      ToastUtil.show(message: Messages.registerSuccess); // 登録成功メッセージ
    } catch (error) {
      print(error.toString());
      ToastUtil.show(message: Messages.registerError); // 登録失敗メッセージ
    }
  }

  // ログイン
  Future<void> loginHandler(User? user, VoidCallback updRouter) async {
    user = user ?? await User.getUser(); // 引数がnullであればuser情報をdbから取得
    try {
      await UserService.login(user); // ログイン処理を待つ
      ToastUtil.show(message: Messages.loginSuccess); // ログイン成功メッセージ
      // routerを再取得
      updRouter();
      // ログイン完了後の処理
      GoRouter.of(context).go('/home');
    } catch (error) {
      ToastUtil.show(message: Messages.loginError); // ログイン失敗メッセージ
    }
  }

  // ユーザー情報取得
  Future<User> getUserHandler() async {
    try {
      return UserService.getUser();
    } catch (error) {
      ToastUtil.show(message: Messages.getUserError);
      return User.errorUser(); // 取得エラー
    }
  }

  // おうちに参加する
  Future<String?> joinOUCHIHandler(String inviteCode) async {
    try {
      return await UserService.joinOUCHI(inviteCode); // クラス参加処理を待つ
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
}
