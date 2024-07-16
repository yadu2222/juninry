import 'package:flutter/material.dart';
import '../../../models/notice_model.dart';

import '../../../constant/fonts.dart';
import '../../../constant/colors.dart';


// 最新のお知らせカード
class LatestNoticeCard extends StatelessWidget {
  const LatestNoticeCard({super.key, required this.noticeData});

  // お知らせ情報
  final Notice noticeData;

  @override
  Widget build(BuildContext context) {
    return Container(
        // margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(3),
        child: Row(children: [
          SizedBox(
            child: Text(
              noticeData.noticeDate,
              style: Fonts.h4,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 10),
            child: Text(
              noticeData.noticeTitle,
              style: Fonts.p,
            ),
          ),
          const Spacer(),
          noticeData.readStatus == 0
              ? const Icon(
                  Icons.error_outline,
                  color: AppColors.buttonCheck,
                )
              : const SizedBox.shrink()
        ]));
  }
}
