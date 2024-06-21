import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:juninry/view/components/atoms/basic_button.dart';
import '../../../models/homework_model.dart';
import '../../../models/notice_register_model.dart';
import '../../components/template/basic_template.dart';
import '../../components/organism/due_homework_list.dart';

import '../../components/atoms/add_button.dart';

import '../../../constant/sample_data.dart'; // sampleData

// 教員_課題一覧ページ
class PageNoticeDraftTeacher extends StatelessWidget {
  final DraftedNotice? draftedNoticeData;

  PageNoticeDraftTeacher({
    super.key,
    this.draftedNoticeData,
  });

  @override
  // TODO カスページ
  Widget build(BuildContext context) {
    return BasicTemplate(title: "下書き", children: [
      Text("タイトルとか"),
      Text(draftedNoticeData?.noticeTitle ?? ""),
      Text(draftedNoticeData?.noticeExplanatory ?? ""),
      Text("クラス名とか"),
      Text(draftedNoticeData?.classData?.className ?? ""),
      Text("引用しているお知らせとか"),
      Text(draftedNoticeData?.quotedNotice?.quotedNoticeTitle ?? ""),
      Text(draftedNoticeData?.quotedNotice?.quotedClassData.className ?? ""),
      BasicButton(
          text: "作成に戻る",
          isColor: false,
          onPressed: () {
            context.go('/notice/register', extra: {
              'draftedNoticeData': SampleData.draftedNoticesData[0],
            });
          }),
    ]);
  }
}
