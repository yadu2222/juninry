import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../components/template/scroll_template.dart';
import '../../components/organism/latest_notice_tab.dart';
import '../../components/organism/shortcuts.dart' as setList;
import '../../components/organism/homework_tabs.dart';

import '../../../constant/sample_data.dart'; // sampleData

class PageHomePatron extends StatelessWidget {
  const PageHomePatron({super.key});

  final String title = 'ホーム';

  @override
  Widget build(BuildContext context) {
    return ScrollTemplate(title: title, children: [
      LatestNoticeTab(noticeData: SampleData.noticesData), // 最新のお知らせタブ
      HomeWorkTabs(homeworkData: SampleData.patronHomeworkData2), // 横スクロール課題タブ
      setList.Shortcuts.patron(), // ショートカットセット
      
    ]);
  }
}
