import 'package:flutter/material.dart';

import './dbcon.dart';
// import '../constant/sample_data.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class User {
  String userName;
  String? userUUID;
  int userTypeId;
  String? mailAddress;
  String? password;
  String? jwtKey;
  String? ouchiUUID;
  int? ouchiPoint;

  User({required this.userName, this.userUUID, required this.userTypeId, required this.mailAddress, required this.password, this.jwtKey, this.ouchiUUID,this.ouchiPoint});

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

  // レスポンスデータをUserに変換
  static User resToUser(http.Response response) {
    try {

      // レスポンスデータをjsonに変換
      Map json = jsonDecode(response.body) as Map<String, dynamic>;
      Map loadData = json['srvResData']['userData'] as Map<String, dynamic>;

      return User(
        userName: loadData['userName'],
        userUUID: loadData['userUUID'] as String?,
        userTypeId: loadData['userTypeId'],
        mailAddress: loadData['mailAddress'] as String?,  
        password: loadData['password'] as String?,
        ouchiUUID: loadData['ouchiUUID'] as String?,
        ouchiPoint: loadData['ouchiPoint'] as int?,
      );
    } catch (e) {
      debugPrint('Error converting map to User: $e');
      return errorUser();
    }
  }

  static User mapToUser(Map map){
    return User(
      userName: map['userName'],
      userUUID: map['userUUID'],
      userTypeId: map['userTypeId'],
      mailAddress: map['mailAddress'],
      password: map['password'],
      jwtKey: map['jwtKey'],
      ouchiUUID: map['ouchiUUID'],
      ouchiPoint: map['ouchiPoint'],
    );
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
