import './student_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Class {
  String? classUUID;
  String className;
  String? inviteCode;
  List<Student>? students;

  Class(
      {this.classUUID,
      required this.className,
      this.students,
      this.inviteCode});

  // レスポンスデータをクラス情報に変換
  static List<Map<String, dynamic>> resToClassmates(http.Response response) {

    // レスポンスデータをjsonに変換
    Map resData = jsonDecode(response.body) as Map<String, dynamic>;

    List<Map<String, dynamic>> classmates = [];
    for (Map loadItem in resData['srvResData']) {
      Map<String, dynamic> addClassInfo = {};
      addClassInfo['className'] = loadItem['className'];
      addClassInfo['students'] = []; // mapに空リストを追加
      for (Map loadStudent in loadItem['juniorData']) {
        addClassInfo['students'].add(Student(
            studentUUID: loadStudent['userUUID'],
            name: loadStudent['userName'],
            gender: loadStudent['genderId'],
            num: loadStudent['studentNumber']));
      }
      classmates.add(addClassInfo);
    }
    return classmates;
  }

  // 単一のクラス情報に変換
  static Class resToClass(http.Response response) {

    // レスポンスデータをjsonに変換
    Map resData = jsonDecode(response.body) as Map<String, dynamic>;
    Map srvResData = resData['srvResData'];

    return Class(
      className: srvResData['className'],
      classUUID: srvResData['classUUID'],
      inviteCode: srvResData['inviteCode'],
    );
  }

  // 複数のクラス情報に変換
  static List<Class> resToClasses(http.Response response) {
     // レスポンスデータをjsonに変換
    Map resData = jsonDecode(response.body) as Map<String, dynamic>;
    List<Map> srvResData = resData['srvResData']['classes'];


      return srvResData.map((data) {
        return Class(
          classUUID: data['classUUID'] ?? '',
          className: data['className'] ?? '',
        );
      }).toList();
   
  }

  // クラスが同一かどうかの判定はclassUUIDの一致とする
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Class && other.classUUID == classUUID;
  }

  @override
  int get hashCode => classUUID.hashCode;
}
