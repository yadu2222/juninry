import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../components/template/scroll_template.dart';
import '../../components/organism/latest_notice_tab.dart';
import '../../components/organism/shortcuts.dart' as setList;
import '../../components/organism/homework_tab.dart';

import '../../../constant/sample_data.dart'; // sampleData

class PageHomeTeacher extends StatelessWidget {
  const PageHomeTeacher({super.key});

  // TODO:教員の所属する教室情報を取得？
  final String title = 'ホーム';

  @override
  Widget build(BuildContext context) {
    return ScrollTemplate(
        title: title,
        // クラス追加+登録のページに遷移
        featureIconButton: IconButton(
          onPressed: () {
            context.go('/home/join');
          },
          iconSize: 35,
          icon: const Icon(Icons.supervisor_account),
        ),
        children: [
          LatestNoticeTab(noticeData: SampleData.noticesData), // 最新のお知らせタブ
          HomeworkTab(homeworkData: SampleData.homeworkData), // 明日提出の課題タブ
          setList.Shortcuts.teacher(), // ショートカットセット
        ]);
  }
}
