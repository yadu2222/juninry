import './teaching_item_model.dart';
import './dbcon.dart';

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

  // クラスでソートし下書きを取得
  // なおす
  // static Future<List<Homework>> getHomeworkDrafts(String classUUID) async {
  //   final List<Map<String, dynamic>> data = await DatabaseHelper.queryBuilder('homeworks', ['class_uuid'], [classUUID], 'homework_limit');
  //   List<Homework> homeworks = [];
  //   for (int i = 0; i < data.length; i++) {
  //     homeworks.add(dBtoHomework(data[i]));
  //   }
  //   return homeworks;
  // }
  // static Future<List<List<Homework>>> getHomeworkDrafts() async {
  //   final List<Map<String, dynamic>> data = await DatabaseHelper.queryAllRows('homeworks');
  //   List<Homework> homeworks = [];
  //   for (int i = 0; i < data.length; i++) {
  //     homeworks.add(dBtoHomework(data[i]));
  //   }
  //   List<List<Homework>> homeworkdrafts = []; // 日付ごとにわけて格納
  //   int draftCount = 0; // 日付ごとのカウント
  //   for (int i = 0; i < homeworks.length; i++) {
  //     if (i != 0) { // 1つめは無条件で追加
  //       if (homeworks[i].homeworkLimit != homeworks[i - 1]) {
  //         draftCount++;
  //       }
  //     }
  //     // リストに追加
  //     homeworkdrafts[draftCount].add(homeworks[i]);
  //   }
  //   return homeworkdrafts;
  // }
  static Future<List<List<Homework>>> getHomeworkDrafts() async {
    final List<Map<String, dynamic>> data = await DatabaseHelper.queryAllRows('homeworks');
    List<Homework> homeworks = [];

    print(data);
    // データベースから取得したデータをHomeworkオブジェクトに変換
    for (int i = 0; i < data.length; i++) {
      homeworks.add(dBtoHomework(data[i]));
    }

    // 日付ごとに宿題をグループ化するためのリスト
    List<List<Homework>> homeworkdrafts = [];

    if (homeworks.isEmpty) {
      return homeworkdrafts;
    }

    // 初期化：最初の宿題を追加
    List<Homework> currentList = [homeworks[0]];
    homeworkdrafts.add(currentList);

    for (int i = 1; i < homeworks.length; i++) {
      if (homeworks[i].homeworkLimit.day != homeworks[i - 1].homeworkLimit.day) {
        // 新しい日付の場合、新しいリストを作成して追加
        currentList = [];
        homeworkdrafts.add(currentList);
      }
      currentList.add(homeworks[i]);
    }

    return homeworkdrafts;
  }
}
