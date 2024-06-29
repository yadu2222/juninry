import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:juninry/view/components/atoms/basic_button.dart';
import '../../../models/drafted_notice_model.dart';
import '../../components/template/basic_template.dart';


import '../../../constant/fonts.dart';
import '../../../models/quoted_notice_model.dart';

// 教員_課題一覧ページ
class PageNoticeDraftTeacher extends StatelessWidget {
  final DraftedNotice? draftedNoticeData;
  final QuotedNotice? quotedNoticeData;

  const PageNoticeDraftTeacher({
    super.key,
    this.draftedNoticeData,
    this.quotedNoticeData,
  });

  @override
  // TODO カスページ
  Widget build(BuildContext context) {




    return BasicTemplate(title: "下書き", children: [
      Text("タイトルとか", style: Fonts.h3),
      Text(draftedNoticeData?.draftedNoticeTitle ?? ""),
      Text(draftedNoticeData?.draftedNoticeExplanatory ?? ""),
      Text("クラス名とか", style: Fonts.h3),
      Text(draftedNoticeData?.selectedClass?.className ?? ""),
      BasicButton(
          text: "下書き1 引用なし",
          isColor: false,
          onPressed: () {
            context.go('/notice/register', extra: {
              'draftedNoticeId': 1,
            });
          }),
      BasicButton(
          text: "下書き2 引用あり",
          isColor: false,
          onPressed: () {
            context.go('/notice/register', extra: {
              'draftedNoticeId': 2,
            });
          }),
      BasicButton(
          text: "引用IDのみ",
          isColor: false,
          onPressed: () {
            context.go('/notice/register', extra: {
              'quotedNoticeUuid': '2097a7bb-5140-460d-807e-7173a51672bd',
            });
          }),
      BasicButton(
        text: "戻る",
        isColor: false,
        onPressed: () {
          context.go('/notice/register');
        },
      )
    ]);
  }
}
