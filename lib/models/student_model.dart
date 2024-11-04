import 'dart:convert';
import 'package:http/http.dart' as http;

class Student {
  String studentUUID;
  String name;
  int? num;
  int? gender; // 性別  1:男性, 2:女性, 3:その他
  int? readStatus;
  Student({required this.studentUUID, required this.name, this.num, required this.gender, this.readStatus});

  static Student mapToStudent(Map<String, dynamic> mapData) {
    return Student(
        studentUUID: mapData['userUUID'] ?? '',
        name: mapData['userName'] as String,
        num: mapData['studentNumber'] as int?,
        gender: mapData['genderId'] as int?,
        readStatus: mapData['readStatus'] as int?);
  }

  static Student resToStudent(http.Response response) {

    // レスポンスデータをjsonに変換
    Map json = jsonDecode(response.body) as Map<String, dynamic>;
    Map resData = json['srvResData'];

    return Student(
        studentUUID: resData['userUUID'] ?? '',
        name: resData['userName'] as String,
        num: resData['studentNumber'] as int?,
        gender: resData['genderId'] as int?,
        readStatus: resData['readStatus'] as int?);
  }

  // 複数の生徒情報に変換
  static List<Student> resToStudents(http.Response response) {
    // レスポンスデータをjsonに変換
    Map resData = jsonDecode(response.body) as Map<String, dynamic>;
    List<Map<String, dynamic>> srvResData = resData['srvResData'];
    List<Student> students = [];
    for (Map<String, dynamic> loadData in srvResData) {
      students.add(Student.mapToStudent(loadData));
    }
    return students;
  }
}
