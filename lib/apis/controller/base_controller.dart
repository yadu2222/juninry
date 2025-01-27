import '../../constant/error.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BaseController {
  BuildContext context;

  BaseController({required this.context});

  Future<T?> execute<T>(Future<T> Function() action) async {
    try {
      return await action();
    } on AuthenticationException {
      context.go("/login");
      handleException(ExceptionType.authenticationException);
      return null;
    } on NetworkException {
      handleException(ExceptionType.networkException);
    }
  }
}
