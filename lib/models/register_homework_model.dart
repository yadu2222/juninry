import 'package:flutter/material.dart';

import './teaching_item_model.dart';
import './dbcon.dart';

// こんなんつくっていいんかなというきもちがある
// きえるかも
class RegisterHomework {
  int? homeworkId;
  DateTime homeworkLimit;
  String classUUID;
  TeachingItem teachingItem;
  TextEditingController noteController;
  TextEditingController startPageController;
  TextEditingController pageCountController;

  RegisterHomework({
    this.homeworkId,
    required this.classUUID,
    required this.homeworkLimit,
    required this.teachingItem,
    TextEditingController? noteController,
    TextEditingController? startPageController,
    TextEditingController? pageCountController,
  })  
  // null かを判別し、初期値を設定
  : noteController = noteController ?? TextEditingController(),
        startPageController = startPageController ?? TextEditingController(),
        pageCountController = pageCountController ?? TextEditingController();

  // mapをHomeworkに変換
  static RegisterHomework dBtoRegisterHomework(Map loadData) {
    try {
      return RegisterHomework(
        homeworkId: loadData['homework_id'],
        homeworkLimit: DateTime.parse(loadData['homework_limit']),
        classUUID: loadData['class_uuid'],
        noteController: TextEditingController(text: loadData['homework_note']),
        startPageController: TextEditingController(text: loadData['start_page'].toString()),
        pageCountController: TextEditingController(text: loadData['page_count'].toString()),
        teachingItem: TeachingItem(
          teachingMaterialUUID: loadData['teaching_material_uuid'],
          teachingMaterialName: loadData['teaching_material_name'],
          subjectId: loadData['subject_id'],
        ),
      );
    } catch (e) {
      print('Error converting map to Homework: $e');
      return RegisterHomework(
        homeworkId: 0,
        homeworkLimit: DateTime.now(),
        classUUID: '',
        noteController: TextEditingController(),
        startPageController: TextEditingController(),
        pageCountController: TextEditingController(),
        teachingItem: TeachingItem(
          teachingMaterialUUID: '',
          teachingMaterialName: '',
          subjectId: 0,
        ),
      );
    }
  }

  // リクエスト用のMAPに変換
  static Map<String, dynamic> toMap(RegisterHomework homework) {
    // ISO8601形式に変換
    DateTime homeworkLimit = DateTime(homework.homeworkLimit.year, homework.homeworkLimit.month, homework.homeworkLimit.day); // 日付のみを設定（時間は00:00:00）

    // UTCに変換し、ISO 8601形式の文字列にする
    String isoDateString = homeworkLimit.toUtc().toIso8601String();

    // 末尾に'Z'を追加
    if (!isoDateString.endsWith('Z')) {
      isoDateString += 'Z';
    }
    return {
      'homeworkLimit': isoDateString,
      'classUUID': homework.classUUID,
      // 'homeworkNote': homework.noteController.text,
      'homeworkNote': homework.noteController.text,
      'startPage': int.tryParse(homework.startPageController.text) ?? 0,
      'pageCount': homework.pageCountController.text != '' ? (int.parse(homework.pageCountController.text) - int.parse(homework.startPageController.text)) : null,
      'teachingMaterialUUID': homework.teachingItem.teachingMaterialUUID,
    };
  }

  // 下書きを保存
  static Future<bool> registerHomeworkDrafts(List<RegisterHomework> homeworks) async {
    for (RegisterHomework homework in homeworks) {
      if (homework.homeworkId != null) {
        // すでに登録されているものは削除して再登録
        deleteHomeworkDrafts(homework);
      }
      Map<String, dynamic> item = {
        'homework_id': homework.homeworkId,
        'homework_limit': homework.homeworkLimit.toString(),
        'class_uuid': homework.classUUID,
        'homework_note': homework.noteController.text,
        'start_page': int.tryParse(homework.startPageController.text) ?? 0,
        'page_count': int.tryParse(homework.pageCountController.text) ?? 0,
        'teaching_material_uuid': homework.teachingItem.teachingMaterialUUID,
        'teaching_material_name': homework.teachingItem.teachingMaterialName,
        'subject_id': homework.teachingItem.subjectId,
      };
      try {
        await DatabaseHelper.insert('homeworkDrafts', item);
        debugPrint('Homework inserted');
      } catch (e) {
        debugPrint('Error inserting homework: $e');
        return false;
      }
    }
    // かくにん
    List<Map<String, dynamic>> test = await DatabaseHelper.queryAllRows('homeworkDrafts'); // こっちはいけてる
    // List<Homework> test = await getHomeworkDrafts(homework.classUuid);
    // final List<Map<String, dynamic>> maps = await DatabaseHelper.queryBuilder('homeworks', ['class_uuid'], ['aaaaa'], 'homework_limit');  // 動作不良
    debugPrint(test.toString());
    return true;
  }

  // idで削除
  static void deleteHomeworkDrafts(RegisterHomework homework) async {
    await DatabaseHelper.delete('homeworkDrafts', 'homework_id', homework.homeworkId.toString());
  }

  // 下書きを取得
  // TODO:日付絞って取得　クラスも絞りなさい！！！！！！！！
  static Future<List<RegisterHomework>> getHomeworkDraftsForDate(DateTime selectDate) async {
    final List<Map<String, dynamic>> data = await DatabaseHelper.getHomeworksForSpecificDate(selectDate.toString());
    // final List<Map<String, dynamic>> data = await DatabaseHelper.queryAllRows('homeworks');

    List<RegisterHomework> homeworks = [];
    for (Map<String, dynamic> item in data) {
      // 整形
      homeworks.add(dBtoRegisterHomework(item));
    }
    return homeworks;
  }

  // TODO:クラスでソートして取得
  // 日付ごとに２次配列化する
  static Future<List<List<RegisterHomework>>> getHomeworkDraftsList() async {
    final List<Map<String, dynamic>> data = await DatabaseHelper.queryAllRows('homeworkDrafts');
    List<RegisterHomework> homeworks = [];

    print(data);
    // データベースから取得したデータをHomeworkオブジェクトに変換
    for (int i = 0; i < data.length; i++) {
      homeworks.add(dBtoRegisterHomework(data[i]));
    }
    // 日付ごとに宿題をグループ化するためのリスト
    List<List<RegisterHomework>> homeworkdrafts = [];

    if (homeworks.isEmpty) {
      return homeworkdrafts;
    }
    // 初期化：最初の宿題を追加
    List<RegisterHomework> currentList = [homeworks[0]];
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
