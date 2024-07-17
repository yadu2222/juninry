import '../constant/messages.dart';
import '../view/components/atoms/toast.dart';

// APIとの通信における例外集

// enumおじさんになることで可読性が上がる？気がする
enum ExceptionType {
  joinClassConflict,
  permittonError,
  DefaultException
}

// ひもづけ
extension ExceptionTypeExtension on ExceptionType {
  String get message {
    switch (this) {
      case ExceptionType.joinClassConflict:
        return Messages.joinClassConflictError ;
      case ExceptionType.permittonError:
        return Messages.permittonError;
      case ExceptionType.DefaultException:
        return Messages.defaultError;
    }
  }
}

// 例外を渡してtoast表示
void handleException(ExceptionType exceptionType) {
  // ここでToastを表示
  ToastUtil.show(message: exceptionType.message);
}


// ーーーー ここに足していってね ーーーー
// enumとひもづけに足すことも忘れずに

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

class DefaultException implements Exception {
  final String message;
  const DefaultException({this.message = Messages.defaultError});
}
