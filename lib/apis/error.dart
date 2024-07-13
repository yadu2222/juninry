import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../constant/messages.dart';
import '../view/components/atoms/toast.dart';

// APIとの通信における例外集

// enumおじさんになることで可読性が上がる？気がする
enum ExceptionType {
  joinClassConflict,
  permittonError,
}

// ひもづけ
extension ExceptionTypeExtension on ExceptionType {
  String get message {
    switch (this) {
      case ExceptionType.joinClassConflict:
        return Messages.joinClassConflictError ;

      case ExceptionType.permittonError:
        return Messages.permittonError;
    }
  }
}

// 使用方法例
void handleException(ExceptionType exceptionType) {
  // ここでToastを表示
  ToastUtil.show(message: exceptionType.message);
}

// すでに参加している
class JoinClassConflictException implements Exception {
  final String message;
  const JoinClassConflictException({this.message = Messages.joinClassConflictError});
}

// 権限がない！！！！！
class PermittionError implements Exception {
  final String message;
  const PermittionError({this.message = Messages.permittonError});
}

class ErrorHandling {
  final BuildContext context;
  ErrorHandling({required this.context});
  // デフォルトのエラーハンドリング関数
  void defaultErrorHandling(http.Response response) {
    // 好きにハンドリングしてくれ
    if (response.statusCode == 409) {
      // すでに参加しているよ
      throw const JoinClassConflictException();
    } else if (response.statusCode == 403) {
      // 権限がないよ
      throw const PermittionError();
    }

    try {
      print('');
    } on PermittionError catch (e) {
      // 権限がないよ
    }
  }
}
