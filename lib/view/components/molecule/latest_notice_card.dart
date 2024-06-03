import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../constant/fonts.dart';
import '../../../constant/colors.dart';

class LatestNoticeCard extends StatelessWidget {
  const LatestNoticeCard({super.key, required this.noticeData});

  // お知らせ情報
  final Map noticeData;

// おしらせID	notice_uuid
// タイトル	notice_title
// 内容	notice_explanatory
// 日付	notice_date
// 投稿者ID	user_uuid
// クラスID	class_uuid
// おしらせID	notice_uuid
// ユーザーID	user_uuid
// 確認の有無 notice_reads

  @override
  Widget build(BuildContext context) {
    return Container(
        // margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(3),
        child: Row(children: [
          SizedBox(
            child: Text(
              noticeData["notice_date"],
              style: Fonts.h4,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 10),
            child: Text(
              noticeData["notice_title"],
              style: Fonts.p,
            ),
          ),
          const Spacer(),
          int.parse(noticeData['notice_reads']) == 0
              ? const Icon(
                  Icons.error_outline,
                  color: AppColors.buttonCheck,
                )
              : const SizedBox.shrink()
        ]));
  }
}
