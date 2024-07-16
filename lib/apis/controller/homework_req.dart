import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'dart:io';
// import '../../models/homework_model.dart';
import '../service/homework_service.dart';
// import 'package:go_router/go_router.dart';

import '../../view/components/atoms/toast.dart';
import '../../../constant/messages.dart';


class HomeworkReq {
  final BuildContext context;

  HomeworkReq({required this.context});

  // 宿題取得
  // 型こわすぎ
  Future<List<dynamic>> getHomeworksHandler() async {
    try {
      return await HomeworkService.getHomeworks(); // 課題取得を待ち返却
    } catch (error) {
      debugPrint(error.toString());
      ToastUtil.show(message: Messages.getHomeworkError);
      return [];
    }
  }

  // 次の日の宿題を取得
  Future<List<dynamic>>  getNextdayHomeworksHandler() async {
    try {
      return await HomeworkService.getNextdayHomeworks(); // 課題取得を待ち返却
    } catch (error) {
      debugPrint(error.toString());
      ToastUtil.show(message: Messages.getHomeworkError);
      return [];
    }
  }

  // 宿題提出
  Future<void> submittionHomework(String homeworkUUID,List<File> files) async{
    try {
      await HomeworkService.submittionHomework(homeworkUUID,files); // 課題提出を待つ
      ToastUtil.show(message: Messages.submittionHomeworkSuccess); 
      GoRouter.of(context).go('/homework');   // 画面遷移

    } catch (error) {
      debugPrint(error.toString());
      ToastUtil.show(message: Messages.submittionHomeworkError);
    }
  }

  // ホーム画面の宿題取得
  // TODO:
  Future<List<dynamic>> getHomeScreenHomeworkHandler() async {
    try {
      return await HomeworkService.getHomeScreenHomework(); // 課題取得を待ち返却
    } catch (error) {
      debugPrint(error.toString());
      ToastUtil.show(message: Messages.getHomeworkError);
      return [];
    }
  }
}
