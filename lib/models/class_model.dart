import './student_model.dart';

class Class {
  String className;
  List<Student> students;
  Class({required this.className, required this.students});


  // レスポンスデータをクラス情報に変換
  static List<Map<String, dynamic>> resToClassmates(List resData) {
    List<Map<String, dynamic>> classmates = [];
    for (Map loadItem in resData) {
      Map<String, dynamic> addClassInfo = {};
      addClassInfo['className'] = loadItem['className'];
      addClassInfo['students'] = [];  // mapに空リストを追加
      for (Map loadStudent in loadItem['juniorData']) {
        addClassInfo['students'].add(Student(name: loadStudent['userName'], gender: loadStudent['genderId']));
      }
      classmates.add(addClassInfo);
    }
    return classmates;
  }
}
