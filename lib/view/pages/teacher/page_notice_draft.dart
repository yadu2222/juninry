import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:juninry/view/components/atoms/basic_button.dart';
import '../../../models/homework_model.dart';
import '../../../models/drafted_notice_model.dart';
import '../../components/template/basic_template.dart';
import '../../components/organism/due_homework_list.dart';

import '../../components/atoms/add_button.dart';

import '../../../constant/sample_data.dart'; // sampleData
import '../../../constant/fonts.dart';

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
      Text("タイトルとか", style: Fonts.h3),
      Text(draftedNoticeData?.noticeTitle ?? ""),
      Text(draftedNoticeData?.noticeExplanatory ?? ""),
      Text("クラス名とか", style: Fonts.h3),
      Text(draftedNoticeData?.selectedClass?.className ?? ""),
      Text("引用しているお知らせとか", style: Fonts.h3),
      Text(draftedNoticeData?.quotedNotice?.quotedNoticeTitle ?? ""),
      Text(draftedNoticeData?.quotedNotice?.quotedClass.className ?? ""),
      BasicButton(
          text: "全部載せ",
          isColor: false,
          onPressed: () {
            context.go('/notice/register', extra: {
              'draftedNoticeData': SampleData.draftedNoticesData[0],
            });
          }),
      BasicButton(
          text: "下書きのみでクラス選択可",
          isColor: false,
          onPressed: () {
            context.go('/notice/register', extra: {
              'draftedNoticeData': SampleData.draftedNoticesData[1],
            });
          }),
      BasicButton(
          text: "引用のみ、クラス固定",
          isColor: false,
          onPressed: () {
            context.go('/notice/register', extra: {
              'draftedNoticeData': SampleData.draftedNoticesData[2],
            });
          }),
      BasicButton(
          text: "今のやつ",
          isColor: false,
          onPressed: () {
            context.go('/notice/register', extra: {
              'draftedNoticeData': draftedNoticeData,
            });
          }),
    ]);
  }
}
