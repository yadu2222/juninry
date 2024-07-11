import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
// import 'package:go_router/go_router.dart';
import 'package:juninry/view/components/template/basic_template.dart';
// import '../../components/template/scroll_template.dart';
import '../../components/organism/latest_notice_tab.dart';
import '../../components/organism/shortcuts.dart' as setList;
import '../../components/organism/homework_tabs.dart';

import '../../../constant/sample_data.dart'; // sampleData

class PageHomePatron extends StatelessWidget {
  const PageHomePatron({super.key});

  final String title = 'ホーム';

  @override
  Widget build(BuildContext context) {
    return BasicTemplate(
        title: title,
        // クラス追加+登録のページに遷移
        // 保護者はクラスに参加できない、、！！！
        // featureIconButton: IconButton(
        //   onPressed: () {
        //     context.go('/home/class');
        //   },
        //   iconSize: 35,
        //   icon: const Icon(Icons.supervisor_account),
        // ),
        children: [
          LatestNoticeTab(noticeData: SampleData.noticesData), // 最新のお知らせタブ
          Flexible(child: HomeWorkTabs(homeworkData: SampleData.patronHomeworkData2)), // 横スクロール課題タブ
          setList.Shortcuts.patron(), // ショートカットセット
        ]);
  }
}
