import 'package:flutter/material.dart';
import 'package:juninry/constant/colors.dart';

import '../../../constant/fonts.dart';
import '../atoms/listitem.dart';
import '../molecule/latest_notice_card.dart';
import '../molecule/divider.dart';

// 最新のお知らせタブ
class LatestNoticeTab extends StatelessWidget {
  LatestNoticeTab({Key? key}) : super(key: key);

  // たった２件表示のために、ファイルを分けるんか、、、！？という気持ちが、ある、検討
  final List<Map> sampleData = [
    {
      'notice_date': '2024-6-3',
      'notice_title': 'お知らせがたくさん',
      'notice_reads': '0',
    },
    {
      'notice_date': '2024-6-2',
      'notice_title': 'ほんのすこしのしんじつ',
      'notice_reads': '1',
    }
  ];

  @override
  Widget build(BuildContext context) {
    return ListItem(
        // height: 130,
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
              LatestNoticeCard(noticeData: sampleData[0]),
              LatestNoticeCard(noticeData: sampleData[1])
            ]));
  }
}
