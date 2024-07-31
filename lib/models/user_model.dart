import 'package:flutter/material.dart';

import './dbcon.dart';
// import '../constant/sample_data.dart';

class User {
  String userName;
  int userTypeId;
  String mailAddress;
  String password;
  String? jwtKey;
  String? ouchiUUID;
  int? ouchiPoint;

  User({required this.userName, required this.userTypeId, required this.mailAddress, required this.password, this.jwtKey, this.ouchiUUID,this.ouchiPoint});

  static User errorUser() {
    return User(userName: '', userTypeId: 0, mailAddress: '', password: '', jwtKey: '', ouchiUUID: '');
  }

  // mapをUserに変換
  static User toUser(Map loadData) {
    try {
      return User(
          userName: 'hoge',
          userTypeId: loadData['user_type_id'] ?? 0,
          mailAddress: loadData['mail_address'],
          password: loadData['password'],
          jwtKey: loadData['jwt_key'],
          ouchiUUID: loadData['ouchi_uuid'],
          ouchiPoint: loadData['ouchi_point']);
    } catch (e) {
      debugPrint('Error converting map to User: $e');
      return errorUser();
    }
  }

  static User resToUser(Map loadData) {
    try {
      return User(
        userName: loadData['userName'],
        userTypeId: loadData['userTypeId'],
        mailAddress: loadData['mailAddress'],
        password: loadData['password'],
        ouchiUUID: loadData['ouchiUUID'],
        ouchiPoint: loadData['ouchiPoint'],
      );
    } catch (e) {
      debugPrint('Error converting map to User: $e');
      return errorUser();
    }
  }

  // ログアウト
  // sqliteから削除
  static Future<bool> logout() async {
    bool isLogout = await DatabaseHelper.logout();
    if (isLogout) {
      // updRouter();
      return true;
    } else {
      // TODO:拾う
      debugPrint('logout error');
      return false;
    }
  }

  // Userをmapに変換
  static Map<String, dynamic> toMap(User user) {
    return {'user_type_id': user.userTypeId, 'mail_address': user.mailAddress, 'password': user.password, 'jwt_key': user.jwtKey, 'ouchi_uuid': user.ouchiUUID};
  }

  // dbからuser情報を取得
  static Future<User> getUser() async {
    debugPrint('getuser');
    if (await DatabaseHelper.firstdb()) {
      var user = await DatabaseHelper.queryAllRows('users');
      debugPrint(user.toString());
      return toUser(user[0]);
    } else {
      debugPrint('no user.');
      return errorUser();
    }
  }

  // ユーザー登録
  static Future<void> insertUser(User user) {
    debugPrint('registerUser');
    DatabaseHelper.insert('users', toMap(user));
    return Future.value();
  }

  // authの更新
  static Future<void> updateUser(User user) async {
    debugPrint('updateUser');
    await DatabaseHelper.update('users', toMap(user));
  }
}
