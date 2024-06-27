import 'package:flutter/material.dart';

import './dbcon.dart';
import '../constant/sample_data.dart';

class User {
  String userUUID;
  String userName;
  int userTypeId;
  String mailAddress;
  String password;
  String jtiUUID;
  String jwtKey;

  User({required this.userUUID, required this.userName, required this.userTypeId, required this.mailAddress, required this.password, required this.jtiUUID,required this.jwtKey});

  // mapをUserに変換
  static User toUser(Map loadData) {
    try {
      return User(
          userUUID: loadData['user_uuid'],
          userName: 'hoge',
          userTypeId: loadData['user_type_id'],
          mailAddress: loadData['mail_address'],
          password: loadData['password'],
          jtiUUID: loadData['jti_uuid'],
          jwtKey: loadData['jwt_key']);
    } catch (e) {
      debugPrint('Error converting map to User: $e');
      return User(userUUID: '', userName: '', userTypeId: 0, mailAddress: '', password: '', jtiUUID: '',jwtKey: '');
    }
  }

  // Userをmapに変換
  static Map<String, dynamic> toMap(User user) {
    return {'user_uuid': user.userUUID, 'user_type_id': user.userTypeId, 'mail_address': user.mailAddress, 'password': user.password, 'jti_uuid': user.jtiUUID,'jwt_key': user.jwtKey};
  }

  // dbからuser情報を取得
  static Future<User> getUser() async {
    if (await DatabaseHelper.firstdb()) {
      var user = await DatabaseHelper.queryAllRows('users');
      debugPrint(user.toString());
      return toUser(user[0]);
    } else {
      debugPrint('できてない？');
      return User(userUUID: '', userName: '', userTypeId: 0, mailAddress: '', password: '', jtiUUID: '',jwtKey: '');
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
    await DatabaseHelper.insert('users', toMap(SampleData.teacherUser));
    await DatabaseHelper.insert('users', toMap(SampleData.juniorUser));
    await DatabaseHelper.insert('users', toMap(SampleData.patronUser));
  }
}
