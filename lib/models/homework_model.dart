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

  // String teachingMaterialUuid;
  // String teachingMaterialName;
  // int subjectId;
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

  static List<Map<String, dynamic>> resToHomeworks(List resData) {
    List<Map<String, dynamic>> homeworks = [];
    // リストをmapに変換
    for (Map loadItem in resData) {
      Map<String, dynamic> addHomeworks = {}; // 追加用のmapを作成 型指定でエラー回避
      addHomeworks['homeworkLimit'] = DateTime.parse(loadItem['homeworkLimit']); // mapに期限を追加
      // print('ちなみにまわっている?1');
      addHomeworks['homeworkData'] = []; // mapに空リストを追加
      // データをHomeworkに変換してリストに追加
      for (Map loadHomework in loadItem['homeworkData']) {
        // print('ちなみにまわっている?2');
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
        // print('ちなみにまわっている?2');
      }
      homeworks.add(addHomeworks);
    }
    return homeworks;
  }

  // static List<Map<String, dynamic>> resToHomeworks(List<dynamic> resData) {
  //   List<Map<String, dynamic>> homeworks = [];

  //   for (var loadItem in resData) {
  //     // 型チェックを行う
  //     if (loadItem is! Map<String, dynamic>) {
  //       continue; // 型が異なる場合はスキップ
  //     }

  //     Map<String, dynamic> addHomeworks = {
  //       'homeworkLimit': loadItem['homeworkLimit'], // キー名の確認と修正
  //       'homeworkData': [] // 空リストを初期化
  //     };

  //     // homework_dataがリストであることを確認
  //     if (loadItem['homeworkData'] is! List) {
  //       continue; // 型が異なる場合はスキップ
  //     }

  //     for (var loadHomework in loadItem['homeworkData']) {
  //       // 型チェックを行う
  //       if (loadHomework is! Map<String, dynamic>) {
  //         continue; // 型が異なる場合はスキップ
  //       }

  //       // Homeworkインスタンスを作成
  //       Homework homework = Homework(
  //         homeworkUuid: loadHomework['homeworkUUID'],
  //         startPage: loadHomework['StartPage'],
  //         pageCount: loadHomework['PageCount'],
  //         homeworkNote: loadHomework['HomeworkNote'],
  //         className: loadHomework['ClassName'],
  //         submitFlg: loadHomework['SubmitFlag'],
  //         teachingItem: TeachingItem(
  //           teachingMaterialUuid: loadHomework['TeachingMaterialUUID'],
  //           teachingMaterialName: loadHomework['TeachingMaterialName'],
  //           subjectId: loadHomework['SubjectId'],
  //         ),
  //       );

  //       // リストに追加
  //       (addHomeworks['homeworkData'] as List).add(homework);
  //     }

  //     homeworks.add(addHomeworks);
  //   }

  //   return homeworks;
  // }

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
      return Homework(
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
    }
  }
}
