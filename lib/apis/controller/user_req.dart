import '../../models/user_model.dart';
import '../service/user_service.dart';

class UserReq {
  // ユーザー登録
  static Future<void> registerUser(Map<String, dynamic> registerUser) async {
    final userData = {
      "userName": "test teacher",
      "userTypeId": 1,
      "mailAddress": "test-teacher@gmail.com",
      "password": "C@tt",
    };

    UserService.registerUser(userData).then((_) {
      // 登録完了後の処理（例えば画面遷移など）
    }).catchError((error) {
      // エラーハンドリング
    });
  }

  // ログイン
  // TODO:updの処理
  static Future<void> login(User? user) async {
    user = user ?? await User.getUser(); // 引数がnullであればuser情報をdbから取得
    UserService.login(user).then((_) {
      // ログイン完了後の処理（例えば画面遷移など）
    }).catchError((error) {
      // エラーハンドリング
    });
  }

  // ユーザー情報取得
  static Future<User> getUser() async {
    return UserService.getUser();
  }
}
