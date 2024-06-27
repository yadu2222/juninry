import 'package:flutter/material.dart';
// import 'package:juninry/view/components/template/basic_template.dart';
import '../../components/template/scroll_template.dart';
import '../../components/organism/latest_notice_tab.dart';
import '../../components/organism/teacher_shortcuts.dart';
import '../../components/organism/homework_tab.dart';

import '../../../constant/sample_data.dart'; // sampleData

import '../../components/atoms/basic_button.dart';
import '../../../apis/controller/user_req.dart';

class PageHomeTeacher extends StatelessWidget {
  const PageHomeTeacher({super.key});

  // TODO:教員の所属する教室情報を取得？
  final String title = 'ホーム';

  //

  @override
  Widget build(BuildContext context) {
    return ScrollTemplate(title: title, children: [
      LatestNoticeTab(noticeData: SampleData.noticesData), // 最新のお知らせタブ
      HomeworkTab(homeworkData: SampleData.homeworkData), // 明日提出の課題タブ
      TeacherShortcuts(), // ショートカットセット

      BasicButton(text: 'とうろく', isColor: true, onPressed: () async => {UserReq.registerUser({})}),
      BasicButton(text: 'ろぐいん', isColor: true, onPressed: () async => {UserReq.login(null)}),
      BasicButton(text: 'げっと', isColor: true, onPressed: () async => {UserReq.getUser()}),
    ]);
  }
}
