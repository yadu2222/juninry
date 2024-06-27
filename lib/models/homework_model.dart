import './teaching_item_model.dart';

class Homework {
  String? homeworkUuid;
  DateTime homeworkLimit; // TODO:dateにすべきでは？
  int startPage;
  int pageCount;
  String homeworkPosterUuid;
  String homeworkNote;
  String? imageUuid;
  String classUuid;
  int? submitFlg;

  // String teachingMaterialUuid;
  // String teachingMaterialName;
  // int subjectId;
  TeachingItem teachingItem;

  Homework({
    this.homeworkUuid,
    required this.homeworkLimit,
    required this.startPage,
    required this.pageCount,
    required this.homeworkPosterUuid,
    required this.homeworkNote,
    this.imageUuid,
    required this.classUuid,
    this.submitFlg,
    required this.teachingItem,
  });

  // mapをHomeworkに変換
  static Homework dBtoHomework(Map loadData) {
    try {
      return Homework(
        homeworkUuid: loadData['homework_id'].toString(),
        homeworkLimit: DateTime.parse(loadData['homework_limit']),
        startPage: loadData['start_page'],
        pageCount: loadData['page_count'],
        homeworkPosterUuid: loadData['homework_poster_uuid'],
        homeworkNote: loadData['homework_note'],
        classUuid: loadData['class_uuid'],
        teachingItem: TeachingItem(
          teachingMaterialUuid: loadData['teaching_material_uuid'],
          teachingMaterialName: loadData['teaching_material_name'],
          subjectId: loadData['subject_id'],
        ),
      );
    } catch (e) {
      print('Error converting map to Homework: $e');
      return Homework(
        homeworkUuid: '',
        homeworkLimit: DateTime.now(),
        startPage: 0,
        pageCount: 0,
        homeworkPosterUuid: '',
        homeworkNote: '',
        imageUuid: '',
        classUuid: '',
        submitFlg: 0,
        teachingItem: TeachingItem(
          teachingMaterialUuid: '',
          teachingMaterialName: '',
          subjectId: 0,
        ),
      );
    }
  }
}
