import 'package:flutter/material.dart';
// import '../../../models/notice_model.dart';

import '../../components/template/basic_template.dart';
import '../../components/organism/latest_notice_tab.dart';
import '../../components/organism/junior_shortcuts.dart';
import '../../components/organism/homework_tab.dart';

import '../../../constant/sample_data.dart'; // sampleData

class PageHomeJunior extends StatelessWidget {
  const PageHomeJunior({super.key});



  final String title = 'ホーム';
  @override
  Widget build(BuildContext context) {
    return BasicTemplate(title: title, children: [
      LatestNoticeTab(noticeData: SampleData.noticeData), // 最新のお知らせタブ
      TaskTab(homeworkData: SampleData.homeworkData), // 明日提出の課題タブ
      JuniorShortcuts() // ショートカットボタン
    ]);
  }
}
