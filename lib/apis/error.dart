import '../constant/messages.dart';
import '../view/components/atoms/toast.dart';

// APIとの通信における例外集

// enumおじさんになることで可読性が上がる？気がする
enum ExceptionType { joinClassConflict, permittonError, homeworkIsEmpty, submittionHomeworkError, DefaultException }

// ひもづけ
extension ExceptionTypeExtension on ExceptionType {

  // 値を保持するためのMapを使用
  static final Map<ExceptionType, int> _values = {};
  String get message {
    switch (this) {
      case ExceptionType.joinClassConflict:
        return Messages.joinClassConflictError;
      case ExceptionType.permittonError:
        return Messages.permittonError;
      case ExceptionType.homeworkIsEmpty:
        return Messages.homeworkIsEmpty;
      case ExceptionType.submittionHomeworkError:
        return Messages.submittionHomeworkError;
      case ExceptionType.DefaultException:
        return Messages.defaultError;
    }
  }

   int get value => _values[this] ?? 0;

  set value(int newValue) {
    if (newValue < 0 || newValue > 4) {
      _values[this] = 4;
    } else {
      _values[this] = newValue;
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

// 宿題が空のとき
class HomeworkIsEmptyException implements Exception {
  final String message;
  const HomeworkIsEmptyException({this.message = Messages.homeworkIsEmpty});
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

// 提出に失敗
class SubmittionHomeworkError implements Exception {
  final String message;
  const SubmittionHomeworkError({this.message = Messages.submittionHomeworkError});
}

class DefaultException implements Exception {
  final String message;
  const DefaultException({this.message = Messages.defaultError});
}
