class Student {
  String studentUUID;
  String name;
  int? num;
  int? gender; // 性別  1:男性, 2:女性, 3:その他
  int? readStatus;
  Student(
      {required this.studentUUID,
      required this.name,
      this.num,
      required this.gender,
      this.readStatus});

  static Student resToStudent(Map<String, dynamic> resData) {
    return Student(
      studentUUID: resData['userUUID'] ?? '',
        name: resData['userName'] as String,
        num: resData['studentNumber'] as int?,
        gender: resData['genderId'] as int?,
        readStatus: resData['readStatus'] as int?);
  }
}
