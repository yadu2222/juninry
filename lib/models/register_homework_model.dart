import 'package:flutter/material.dart';

import './teaching_item_model.dart';
import './dbcon.dart';
import './user_model.dart';

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
  })  : noteController = noteController ?? TextEditingController(),
        startPageController = startPageController ?? TextEditingController(),
        pageCountController = pageCountController ?? TextEditingController();
  // 下書きを保存
  static Future<void> registerHomeworkDrafts(List<RegisterHomework> homeworks) async {
    // user情報を取得 idを取得するため
    User user = await User.getUser();

    for (RegisterHomework homework in homeworks) {

      if(homework.homeworkId != null) {
        // すでに登録されているものは削除して再登録
        deleteHomeworkDrafts(homework);
      }
      Map<String, dynamic> item = {
        'homework_limit': homework.homeworkLimit.toString(),
        'start_page': int.tryParse(homework.startPageController.text) ?? 0,
        'page_count': int.tryParse(homework.pageCountController.text) ?? 0,
        'homework_poster_uuid': user.userUUID,
        'homework_note': homework.noteController.text,
        'class_uuid': homework.classUUID,
        'teaching_material_uuid': homework.teachingItem.teachingMaterialUuid,
        'teaching_material_name': homework.teachingItem.teachingMaterialName,
        'subject_id': homework.teachingItem.subjectId,
      };
      try {
        await DatabaseHelper.insert('homeworks', item);
        print('Homework inserted');
      } catch (e) {
        print('Error inserting homework: $e');
      }
    }
    // かくにん
    List<Map<String, dynamic>> test = await DatabaseHelper.queryAllRows('homeworks'); // こっちはいけてる
    // List<Homework> test = await getHomeworkDrafts(homework.classUuid);
    // final List<Map<String, dynamic>> maps = await DatabaseHelper.queryBuilder('homeworks', ['class_uuid'], ['aaaaa'], 'homework_limit');  // 動作不良

    // print(maps);
    // print(homework.classUuid);
    print(test);
   
  }

  // idで削除
  static void deleteHomeworkDrafts(RegisterHomework homework) async {
    await DatabaseHelper.delete('homeworks', 'homework_id', homework.homeworkId.toString());
  }

  static Future<List<RegisterHomework>> getHomeworkDrafts(DateTime selectDate) async {
  //  final List<Map<String, dynamic>> data = await DatabaseHelper.queryBuilder('homeworks', ['homework_limit'], ["${selectDate.year.toString()}-${selectDate.month.toString()}-${selectDate.day.toString}"], 'homework_id');
  final List<Map<String, dynamic>> data = await DatabaseHelper.queryAllRows('homeworks');

    List<RegisterHomework> homeworks = [];
    for (Map<String, dynamic> item in data) {
      homeworks.add(RegisterHomework(
        homeworkId: item['homework_id'],
        classUUID: item['class_uuid'],
        homeworkLimit: DateTime.parse(item['homework_limit']),
        noteController: TextEditingController(text: item['homework_note']),
        startPageController: TextEditingController(text: item['start_page'].toString()),
        pageCountController: TextEditingController(text: item['page_count'].toString()),
        teachingItem: TeachingItem(
          teachingMaterialUuid: item['teaching_material_uuid'],
          teachingMaterialName: item['teaching_material_name'],
          subjectId: item['subject_id'],
        ),
      ));
    }
    return homeworks;
  }
}
