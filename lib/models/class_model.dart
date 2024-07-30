import './student_model.dart';

class Class {
  String? classUUID;
  String className;
  String? inviteCode;
  List<Student>? students;

  Class({this.classUUID, required this.className, this.students, this.inviteCode});

  // レスポンスデータをクラス情報に変換
  static List<Map<String, dynamic>> resToClassmates(List resData) {
    List<Map<String, dynamic>> classmates = [];
    for (Map loadItem in resData) {
      Map<String, dynamic> addClassInfo = {};
      addClassInfo['className'] = loadItem['className'];
      addClassInfo['students'] = []; // mapに空リストを追加
      for (Map loadStudent in loadItem['juniorData']) {
        addClassInfo['students'].add(Student(studentUUID: loadStudent['userUUID'], name: loadStudent['userName'], gender: loadStudent['genderId'],num:loadStudent['studentNumber']));
      }
      classmates.add(addClassInfo);
    }
    return classmates;
  }

  // 単一のクラス情報に変換
  static Class resToClass(Map resData) {
    return Class(
      className: resData['className'],
      classUUID: resData['classUUID'],
      inviteCode: resData['inviteCode'],
    );
  }

  // 複数のクラス情報に変換
  static List<Class> resToClasses(List loadData) {
    try {
        return loadData.map((data) {
        return Class(
          classUUID: data['classUuid'] ?? '',
          className: data['className'] ?? '',
        );
      }).toList();
    } catch (e) {
      print("クラス情報を取得できませんでした: $e");
      return [];
    }
  }
}
