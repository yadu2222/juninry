class Student {
  String studentUUID;
  String name;
  int? num;
  int gender; // 性別  1:男性, 2:女性, 3:その他
  Student({required this.studentUUID, required this.name, this.num, required this.gender});
}
