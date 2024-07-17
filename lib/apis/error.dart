import '../constant/messages.dart';
import '../view/components/atoms/toast.dart';

// APIとの通信における例外集

// enumおじさんになることで可読性が上がる？気がする
enum ExceptionType {
  joinClassConflict,
  permittonError,
  homeworkIsEmpty,
  submittionHomeworkError,
}

// ひもづけ
extension ExceptionTypeExtension on ExceptionType {
  String get message {
    switch (this) {
      case ExceptionType.joinClassConflict:
        return Messages.joinClassConflictError ;
      case ExceptionType.permittonError:
        return Messages.permittonError;
      case ExceptionType.homeworkIsEmpty:
        return Messages.homeworkIsEmpty;
      case ExceptionType.submittionHomeworkError:
        return Messages.submittionHomeworkError;
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
