// おしらせ詳細タブ

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:juninry/models/notice_model.dart';
import 'package:juninry/models/quoted_notice_model.dart';
import 'package:juninry/view/components/atoms/listitem.dart';
import 'package:juninry/view/components/molecule/quote_from_notice.dart';
import '../molecule/divider.dart';

import '../../../constant/fonts.dart';
import '../../../constant/colors.dart';

class NoticeDetailTab extends StatelessWidget {
  NoticeDetailTab({super.key, required this.tabData, this.quotedNoticeData});

  // fields
  final Notice tabData;
  final (String, String)? quotedNoticeData;

  @override
  Widget build(BuildContext context) {
    return ListItem(
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
        widget: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween, //  両端寄せ
              children: [
                // ひづけ
                Text(
                  tabData.noticeDate!,
                  style: Fonts.p,
                ),
                // クラス名
                Text(
                  tabData.className!,
                  style: Fonts.p,
                )
              ],
            ),
            // おてがみのタイトル
            Text(
              tabData.noticeTitle,
              style: Fonts.h4,
            ),
            // バー
            const DividerView(
              dividColor: AppColors.main,
              dividWeight: 2.5,
              indent: 0,
              endIndent: 0,
            ),

            // 本文
            Text(
              tabData.noticeExplanatory!,
              style: Fonts.p,
            ),

            const SizedBox(
              height: 20,
            ),
            quotedNoticeData == null
                ? Container()
                : QuoteFromNotice(
                    onQuoteClicked: () {
                      debugPrint("何でだろう?");
                      context.go('/notice/detail',
                          extra: {'noticeUUID': quotedNoticeData!.$1});
                    },
                    onDeleteClicked: () {},
                    quoteNoticeTitle: quotedNoticeData!.$1,
                    isDivider: false,
                  ),
          ],
        ));
  }
}
