import 'package:flutter/material.dart';
import '../../../models/notice_model.dart';

import '../../components/template/basic_template.dart';
import '../../components/organism/latest_notice_tab.dart';
import '../../components/organism/junior_shortcuts.dart';
import '../../components/organism/homework_tab.dart';

class PageHomeJunior extends StatelessWidget {
  PageHomeJunior({super.key});

  // 最新２件のサンプル
  final List<Notice> sampleData = [
    Notice(noticeTitle: 'お知らせがたくさん', noticeDate: '2024-6-3', noticeRead:  '0'),
    Notice(noticeTitle: 'ほんのすこしのしんじつ', noticeDate: '2024-6-2', noticeRead: '1')
  ];

  final String title = 'ホーム';
  @override
  Widget build(BuildContext context) {
    return BasicTemplate(title: title, children: [
      LatestNoticeTab(noticeData:sampleData), // 最新のお知らせタブ
      TaskTab(), // 明日提出の課題タブ
      JuniorShortcuts() // ショートカットボタン
    ]);
  }
}
