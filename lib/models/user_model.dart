import 'package:flutter/material.dart';

import './dbcon.dart';
// import '../constant/sample_data.dart';

class User {
  String userUUID;
  String userName;
  int userTypeId;
  String mailAddress;
  String password;
  String jtiUUID;
  String jwtKey;

  User({this.userUUID = 'userUUID',  required this.userName, required this.userTypeId, required this.mailAddress, required this.password, required this.jtiUUID, required this.jwtKey});

  static User errorUser() {
    return User(userName: '', userTypeId: 0, mailAddress: '', password: '', jtiUUID: '', jwtKey: '');
  }

  // mapをUserに変換
  static User toUser(Map loadData) {
    try {
      return User(
          userUUID: loadData['user_uuid'],
          userName: 'hoge',
          userTypeId: loadData['user_type_id'] ?? 0,
          mailAddress: loadData['mail_address'],
          password: loadData['password'],
          jtiUUID: loadData['jti_uuid'],
          jwtKey: loadData['jwt_key']);
    } catch (e) {
      debugPrint('Error converting map to User: $e');
      return errorUser();
    }
  }

  static User resToUser(Map loadData) {
    try {
      return User(
          userUUID: loadData['userUUID'],
          userName: loadData['userName'],
          userTypeId: loadData['userTypeId'],
          mailAddress: loadData['mailAddress'],
          password: loadData['password'],
          jtiUUID: loadData['jwtUUID'], // いらないのでは？
          jwtKey: loadData['jwtUUID']);
    } catch (e) {
      debugPrint('Error converting map to User: $e');
      return errorUser();
    }
  }

  // Userをmapに変換
  static Map<String, dynamic> toMap(User user) {
    return {'user_uuid':user.userUUID, 'user_type_id': user.userTypeId, 'mail_address': user.mailAddress, 'password': user.password, 'jti_uuid': user.jtiUUID, 'jwt_key': user.jwtKey};
  }

  // dbからuser情報を取得
  static Future<User> getUser() async {
    if (await DatabaseHelper.firstdb()) {
      var user = await DatabaseHelper.queryAllRows('users');
      debugPrint(user.toString());
      return toUser(user[0]);
    } else {
      debugPrint('できてない？');
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
    await DatabaseHelper.update('users', 'mail_address', toMap(user), user.mailAddress);
  }

  // 既にdbが存在しているかを判定し、なければsampleuserを追加
  // のちのちはユーザー追加がなくなるはず
  static dbSampleUserAdd() async {
    debugPrint('dbSampleUserAdd');
    if (!await DatabaseHelper.firstdb()) {
      _createSampleUser();
    }
  }

  // type_idは本来apiからもらうものだが、テストに使いたいため個々に記載
  static _createSampleUser() async {
    debugPrint('_createSampleUser');
    // await DatabaseHelper.insert('users', toMap(SampleData.teacherUser));
    // await DatabaseHelper.insert('users', toMap(SampleData.juniorUser));
    // await DatabaseHelper.insert('users', toMap(SampleData.patronUser));
  }
}
