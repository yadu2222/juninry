import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:juninry/apis/error_handler.dart';
import 'package:juninry/constant/error.dart';
import 'package:juninry/models/homework_model.dart';
import 'package:juninry/models/homework_submission_record.dart';
import 'dart:io';
import '../../models/register_homework_model.dart';
import '../../models/teaching_item_model.dart';
import '../service/homework_service.dart';

import '../../view/components/atoms/toast.dart';
import '../../../constant/messages.dart';

class HomeworkReq {
  final BuildContext context;

  HomeworkReq({required this.context});

  // 宿題登録
  Future<void> registerHomeworkHandler(List<RegisterHomework> registerHomeworks) async {
    try {
      for (RegisterHomework homework in registerHomeworks) {
        print(homework.homeworkLimit);
      }

      for (RegisterHomework registerHomework in registerHomeworks) {
        await HomeworkService.registerHomework(registerHomework); // 課題登録を待つ
      }
      ToastUtil.show(message: Messages.registerSuccess);
      GoRouter.of(context).go('/homework'); // 画面遷移
      // } on RegisterHomeworkError {
      //   // handleException(ExceptionType.registerHomeworkError);
      // }
    } catch (e) {
      print(e);
      ToastUtil.show(message: Messages.registerError);
    }
  }

  // 教材データを取得
  Future<List<TeachingItem>> getTeachingItemsHandler(String classUUID) async {
    try {
      return await HomeworkService.getTeachingItems(classUUID); // 教材データ取得を待ち返却
    } catch (e) {
      print(e);
      return [];
    }
  }

  // 宿題取得
  Future<Homework?> getHomeworkHandler(String homeworkUUID) async {
    try {
      return await HomeworkService.getHomework(homeworkUUID); // 課題取得を待ち返却
    } on HomeworkIsEmptyException {
      handleException(ExceptionType.homeworkIsEmpty);
      return null;
    }
  }

  // 宿題取得
  // 型こわすぎ
  Future<List<dynamic>> getHomeworksHandler() async {
    try {
      return await HomeworkService.getHomeworks(); // 課題取得を待ち返却
    } on HomeworkIsEmptyException {
      handleException(ExceptionType.homeworkIsEmpty);
      return [];
    }
  }

  // 次の日の宿題を取得
  Future<List<dynamic>> getNextdayHomeworksHandler() async {
    try {
      return await HomeworkService.getNextdayHomeworks(); // 課題取得を待ち返却
    } on HomeworkIsEmptyException {
      handleException(ExceptionType.homeworkIsEmpty);
      return [];
    }
  }

  // 宿題提出
  Future<void> submittionHomework(String homeworkUUID, List<File> files) async {
    try {
      await HomeworkService.submittionHomework(homeworkUUID, files); // 課題提出を待つ
      ToastUtil.show(message: Messages.submittionHomeworkSuccess);
      GoRouter.of(context).go('/homework'); // 画面遷移
    } on SubmittionHomeworkError {
      handleException(ExceptionType.submittionHomeworkError);
    }
  }

  // ホーム画面の宿題取得
  Future<List<dynamic>> getHomeScreenHomeworkHandler() async {
    try {
      return await HomeworkService.getHomeScreenHomework(); // 課題取得を待ち返却
    } on HomeworkIsEmptyException {
      handleException(ExceptionType.homeworkIsEmpty);
      return [];
    } on AuthenticationException {
      authCatch(context);
      return [];
    }
  }

  Future<List<HomeworkSubmissionRecord>> submissionLogHandler(DateTime targetMonth) async {
    try {
      return await HomeworkService.submissionLog(targetMonth);
    } on DefaultException {
      handleException(ExceptionType.DefaultException);
      return [];
    }
  }

  // 宿題の画像を取得
  Future<File?> getHomeworkImage(String homeworkUUID, String imageFileName) async {
    try {
      return await HomeworkService.getHomeworkImage(homeworkUUID, imageFileName);
    } on DefaultException {
      handleException(ExceptionType.DefaultException);
      return null;
    }
  }
}
