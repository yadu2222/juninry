import 'package:flutter/material.dart';

import './teaching_item_model.dart';
import './dbcon.dart';
import './user_model.dart';

// こんなんつくっていいんかなというきもちがある
// きえるかも
class RegisterHomework {
  DateTime homeworkLimit;
  String classUUID;
  TeachingItem teachingItem;
  TextEditingController noteController = TextEditingController();
  TextEditingController startPageController = TextEditingController();
  TextEditingController pageCountController = TextEditingController();

  RegisterHomework({
    required this.classUUID,
    required this.homeworkLimit,
    required this.teachingItem,
  });

  // 下書きを保存
  static Future<void> registerHomeworkDrafts(List<RegisterHomework> homeworks) async {

    // user情報を取得 idを取得するため
    User user = await User.getUser();

    for (RegisterHomework homework in homeworks) {
      Map<String, dynamic> item = {
        'homework_limit': homework.homeworkLimit.toString(),
        'start_page': int.parse(homework.startPageController.text),
        'page_count': int.parse(homework.pageCountController.text),
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
    // print(test);
  }
}
