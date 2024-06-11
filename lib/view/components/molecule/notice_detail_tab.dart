// おしらせ詳細タブ

import 'package:flutter/material.dart';
import 'package:juninry/view/components/atoms/listitem.dart';
import '../molecule/divider.dart';

import '../../../constant/fonts.dart';
import '../../../constant/colors.dart';

class NoticeDetailTab extends StatelessWidget {
  NoticeDetailTab({super.key, required this.tabData});

  // fields
  final Map tabData;

  @override
  Widget build(BuildContext context) {
    return ListItem(
        padding: EdgeInsets.all(20),
        widget: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween, //  両端寄せ
              children: [
                // ひづけ
                Text(
                  tabData["noticeDate"],
                  style: Fonts.p,
                ),
                // クラス名
                Text(
                  tabData["className"],
                  style: Fonts.p,
                )
              ],
            ),
            // おてがみのタイトル
            Text(
              tabData["noticeTitle"],
              style: Fonts.h4,
            ),
            // バー
            DividerView(
              dividColor: AppColors.main,
              dividWeight: 2.5,
              indent: 0,
              endIndent: 0,
            ),
            // 本文
            Text(
              tabData["noticeExplanatory"],
              style: Fonts.p,
            )
          ],
        ));
  }
}
