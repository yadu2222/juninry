import 'package:flutter/material.dart';
import '../../components/template/basic_template.dart';
import '../../components/organism/latest_notice_tab.dart';
import '../../components/organism/patron_shortcuts.dart';
import '../../components/organism/homework_tabs.dart';

import '../../../constant/sample_data.dart'; // sampleData

class PageHomePatron extends StatelessWidget {
  const PageHomePatron({Key? key}) : super(key: key);

  final String title = 'ホーム';
  @override
  Widget build(BuildContext context) {
    return BasicTemplate(title: title, children: [
      LatestNoticeTab(noticeData: SampleData.noticesData), // 最新のお知らせタブ
      HomeWorkTabs(homeworkData: SampleData.patronHomeworkData2), // 横スクロール課題タブ
      PatronShortcuts() // ショートカットセット
    ]);
  }
}
