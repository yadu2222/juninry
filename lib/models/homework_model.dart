import './teaching_item_model.dart';

class Homework {
  String? homeworkUuid;
  DateTime? homeworkLimit; // TODO:dateにすべきでは？
  int startPage;
  int pageCount;
  String? homeworkPosterUuid;
  String homeworkNote;
  String? imageUuid;
  String className;
  int? submitFlg;
  TeachingItem teachingItem;

  Homework({
    this.homeworkUuid,
    this.homeworkLimit,
    required this.startPage,
    required this.pageCount,
    this.homeworkPosterUuid,
    required this.homeworkNote,
    this.imageUuid,
    required this.className,
    this.submitFlg,
    required this.teachingItem,
  });

  static Homework errHomework = Homework(
    homeworkUuid: '',
    homeworkLimit: DateTime.now(),
    startPage: 0,
    pageCount: 0,
    homeworkPosterUuid: '',
    homeworkNote: '',
    imageUuid: '',
    className: '',
    submitFlg: 0,
    teachingItem: TeachingItem(
      teachingMaterialImageUUID: '',
      teachingMaterialName: '',
      subjectId: 0,
    ),
  );

  // 失敗したらサービスでエラーを返す
  // のでここでは特に対応しない
  // keyで指定した値をmapの頭に配置(つたわれ)
  // このかたちになる
  // [
  //   {
  //     'key': 'value',
  //     'homeworkData': []
  //   },
  //]
  // 型が安全じゃなさすぎるだろという怒り
  static List<dynamic> resToHomeworks(List resData, String? key) {
    List<dynamic> homeworks = [];
    // リストをmapに変換
    try {
      if (key != null) {
        for (Map loadItem in resData) {
          Map<String, dynamic> addHomeworks = {}; // 追加用のmapを作成 型指定でエラー回避
          // nullチェック
          addHomeworks[key] = DateTime.parse(loadItem[key]); // mapにkeyを追加
          addHomeworks['homeworkData'] = []; // mapに空リストを追加
          // データをHomeworkに変換してリストに追加
          for (Map loadHomework in loadItem['homeworkData']) {
            Homework homework = Homework(
              homeworkUuid: loadHomework['homeworkUUID'],
              startPage: loadHomework['StartPage'],
              pageCount: loadHomework['PageCount'],
              homeworkNote: loadHomework['HomeworkNote'],
              className: loadHomework['ClassName'],
              submitFlg: loadHomework['SubmitFlag'],
              teachingItem: TeachingItem(
                teachingMaterialImageUUID: loadHomework['TeachingMaterialImageUUID'], // 教材そのもののUUIDはこないらしいぞ！(そうなの！！？)
                teachingMaterialName: loadHomework['TeachingMaterialName'],
                subjectId: loadHomework['SubjectId'],
              ),
            );
            // 先ほど追加した空リストに宿題を追加
            addHomeworks['homeworkData'].add(homework);
            // print(homework.toString());
          }
          homeworks.add(addHomeworks);
        }
      } else {
        // 一つのリストにまとめる
        
        for (Map loadItem in resData) {
          for (Map loadHomework in loadItem['homeworkData']) {
            Homework homework = Homework(
              homeworkUuid: loadHomework['homework_id'],
              homeworkLimit: DateTime.parse(loadHomework['homework_limit']),
              startPage: loadHomework['start_page'],
              pageCount: loadHomework['page_count'],
              homeworkPosterUuid: loadHomework['homework_poster_uuid'],
              homeworkNote: loadHomework['homework_note'],
              className: loadHomework['class_uuid'],
              teachingItem: TeachingItem(
                teachingMaterialImageUUID: loadHomework['teaching_material_uuid'],
                teachingMaterialName: loadHomework['teaching_material_name'],
                subjectId: loadHomework['subject_id'],
              ),
            );
            homeworks.add(homework);
          }
        }
      }
      return homeworks;
    } catch (e) {
      return [];
    }
  }

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
        className: loadData['class_uuid'],
        teachingItem: TeachingItem(
          teachingMaterialImageUUID: loadData['teaching_material_uuid'],
          teachingMaterialName: loadData['teaching_material_name'],
          subjectId: loadData['subject_id'],
        ),
      );
    } catch (e) {
      print('Error converting map to Homework: $e');
      return errHomework;
    }
  }
}
