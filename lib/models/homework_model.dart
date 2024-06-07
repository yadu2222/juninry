class Homework {
  String homeworkUuid;
  DateTime homeworkLimit;
  String teachingMaterialUuid;
  int startPage;
  int pageCount;
  String homeworkPosterUuid;
  String homeworkNote;
  String teachingMaterialName;
  int subjectId;
  String imageUuid;
  String classUuid;
  int submitFlg;

  Homework({
    required this.homeworkUuid,
    required this.homeworkLimit,
    required this.teachingMaterialUuid,
    required this.startPage,
    required this.pageCount,
    required this.homeworkPosterUuid,
    required this.homeworkNote,
    required this.teachingMaterialName,
    required this.subjectId,
    required this.imageUuid,
    required this.classUuid,
    required this.submitFlg,
  });

}
