import './teaching_item_model.dart';
import './dbcon.dart';

class Homework {
  String? homeworkUuid;
  String homeworkLimit; // TODO:dateにすべきでは？
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
  static Homework toHomework(Map loadData) {
    try {
      return Homework(
        homeworkUuid: loadData['homework_id'].toString(),
        homeworkLimit: loadData['homework_limit'],
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
        homeworkLimit: '',
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


  // 下書きを保存
  static Future<void> registerHomeworkDtafts(Homework homework) async{
    Map<String, dynamic> item = {
      'homework_limit': homework.homeworkLimit,
      'start_page': homework.startPage,
      'page_count': homework.pageCount,
      'homework_poster_uuid': homework.homeworkPosterUuid,
      'homework_note': homework.homeworkNote,
      'class_uuid': homework.classUuid,
      'teaching_material_uuid': homework.teachingItem.teachingMaterialUuid,
      'teaching_material_name': homework.teachingItem.teachingMaterialName,
      'subject_id': homework.teachingItem.subjectId,
    };
    await DatabaseHelper.insert('homeworks', item);
  }


  // クラスでソートし下書きを取得
  static Future<List<Homework>> getHomeworkDrafts(String classUUID) async {
    final List<Map<String, dynamic>> maps = await DatabaseHelper.queryBuilder('homeworks',['class_uuid'],[classUUID],'homework_limit');
    List<Homework> homeworks = [];
    for (int i = 0; i < maps.length; i++) {
      homeworks.add(toHomework(maps[i]));
    }
    return homeworks;
  }
}
