import 'package:flutter/material.dart';
import '../../../models/notice_model.dart';

import 'package:juninry/constant/colors.dart';
import '../../../constant/fonts.dart';

import '../atoms/listitem.dart';
import '../molecule/latest_notice_card.dart';
import '../molecule/divider.dart';

// 最新のお知らせタブ
class LatestNoticeTab extends StatelessWidget {
  const LatestNoticeTab({super.key, required this.noticeData});

  final List<Notice> noticeData;

  @override
  Widget build(BuildContext context) {
    return ListItem(
        // height: 130,
        margin: const EdgeInsets.only(
          left: 15,
          right: 15,
        ),
        padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
        // ここに箱の中に表示したいウィジェットを入れる
        widget: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // 左寄せ
            children: [
              const Text('最新のお知らせ', style: Fonts.h1),
              const DividerView(
                dividColor: AppColors.main,
                indent: 0,
                endIndent: 0,
              ),
              LatestNoticeCard(noticeData: noticeData[0]),
              LatestNoticeCard(noticeData: noticeData[1])
            ]));
  }
}
