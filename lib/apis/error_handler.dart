import 'package:http/http.dart' as http;
import '../constant/error.dart';

class ErrorHandler {
  static void defaultHandler(http.Response response) {
    if (response.statusCode > 300) {
      if (response.statusCode == 403) {
        throw PermittionError();
      } else if (response.statusCode == 401) {
        throw AuthenticationException();
      } else {
        throw DefaultException();
      }
    }
  }

  static void classErrorHandler(http.Response response) {
    if (response.statusCode == 403) {
      throw PermittionError();
    } else if (response.statusCode == 409) {
      throw JoinClassConflictException();
    }
    defaultHandler(response);
  }

  static void userErrorHandler(http.Response response) {
    if (response.statusCode == 403) {
      throw PermittionError();
    }
    defaultHandler(response);
  }

  static void helpErrorHandler(http.Response response) {
    if (response.statusCode == 403) {
      throw PermittionError();
    }
    defaultHandler(response);
  }

  static void homeworkErrorHandler(http.Response response) {
    if (response.statusCode == 403) {
      throw PermittionError();
    }
    defaultHandler(response);
  }

  static void noticeErrorHandler(http.Response response) {
    if (response.statusCode == 403) {
      throw PermittionError();
    }
    defaultHandler(response);
  }

  static void ouchiErrorHandler(http.Response response) {
    if (response.statusCode == 403) {
      throw PermittionError();
    }
    defaultHandler(response);
  }

  static void rewardErrorHandler(http.Response response) {
    if (response.statusCode == 403) {
      throw PermittionError();
    }
    defaultHandler(response);
  }

  static void collectionErrorHandler(http.Response response) {
    if (response.statusCode == 403) {
      throw PermittionError();
    }
    defaultHandler(response);
  }
}
