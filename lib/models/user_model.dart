import 'package:flutter/material.dart';

import './dbcon.dart';

class User {
  String userUUID;
  String userName;
  int userTypeId;
  String mailAddress;
  String password;

  User({
    required this.userUUID,
    required this.userName,
    required this.userTypeId,
    required this.mailAddress,
    required this.password,
  });

  // mapをUserに変換
  static User toUser(Map loadData) {
    try {
      return User(
        userUUID: loadData['user_uuid'],
        userName: 'hoge',
        userTypeId: loadData['user_type_id'],
        mailAddress: loadData['mail_address'],
        password: loadData['password'],
      );
    } catch (e) {
      debugPrint('Error converting map to User: $e');
      return User(
        userUUID: '',
        userName: '',
        userTypeId: 0,
        mailAddress: '',
        password: '',
      );
    }
  }

  // dbからuser情報を取得
  static Future<User> getUser() async {
    if (await DatabaseHelper.firstdb()) {
      var user = await DatabaseHelper.queryAllRows('users');
      debugPrint(user.toString());
      return toUser(user[2]);
    } else {
      debugPrint('できてない？');
      return User(
        userUUID: '',
        userName: '',
        userTypeId: 0,
        mailAddress: '',
        password: '',
      );
    }
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
    var juniorSampleUser = {'user_uuid': '5574bc10-c1f4-46e7-bbac-8503e03bab', 'user_type_id': 0, 'mail_address': 'junior@gmail.com', 'password': '12345678'};
    var patronrSampleUser = {'user_uuid': '5574bc10-c1f4-46e7-bbac-803ee03bafb', 'user_type_id': 1, 'mail_address': 'patron@gmail.com', 'password': '12345678'};
    var teacherSampleUser = {'user_uuid': '5574bc10-c1f4-46e7-bbac-8503ee03afb', 'user_type_id': 2, 'mail_address': 'teacher@gmail.com', 'password': '12345678'};
    var debugSampleUser = {'user_uuid': '5574bc10-c1f4-46e7-bbac-8503ee3bafb', 'user_type_id': 3, 'mail_address': 'debug@gmail.com', 'password': '12345678'};

    await DatabaseHelper.insert('users', juniorSampleUser);
    await DatabaseHelper.insert('users', patronrSampleUser);
    await DatabaseHelper.insert('users', teacherSampleUser);
    await DatabaseHelper.insert('users', debugSampleUser);
  }
}
