import 'package:flutter/material.dart';
import 'package:juninry/constant/colors.dart';
import '../../../models/notice_model.dart';
import '../atoms/listitem.dart';
import '../../../constant/fonts.dart';
import 'package:go_router/go_router.dart';

// お知らせカード
class NoticeCard extends StatelessWidget {
  // お知らせデータ
  final Notice noticeData;

  // 引用ページか否か
  final bool isQuote;

  // 教師だったら既読ないよー
  final bool isTeacher;

  const NoticeCard({
    super.key,
    required this.noticeData,
    required this.isQuote,
    required this.isTeacher,
  });

  // 未確認アイコン
  final Icon unknownIcon = const Icon(
    Icons.error_outline,
    color: AppColors.buttonCheck,
    size: 36,
  );

  final Icon checkIcon = const Icon(
    Icons.check_circle,
    color: AppColors.buttonOk,
    size: 36,
  );

  @override
  Widget build(BuildContext context) {
    return ListItem(
      padding: const EdgeInsets.only(top: 7, bottom: 10, left: 20, right: 20),
      widget: InkWell(
        onTap: () {
          debugPrint("noticeUUID: ${noticeData.noticeUUID}");
          final route = isQuote
              ? '/notice/register'
              : '/notice/detail';
          final extra = isQuote
              ? {'quotedNoticeUUID': noticeData.noticeUUID}
              : {'noticeUUID': noticeData.noticeUUID};
          context.go(route, extra: extra);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    // 日付け
                    Text(
                      noticeData.noticeDate!,
                      style: Fonts.h3,
                    ),
                    const SizedBox(width: 15),
                    // 学年
                    Text(
                      noticeData.className!,
                      style: Fonts.py,
                    ),
                  ],
                ),
                // 見出し
                Row(
                  children: [
                    const SizedBox(width: 2),
                    Text(
                      noticeData.noticeTitle,
                      style: Fonts.notice,
                    ),
                  ],
                ),
              ],
            ),
            // アイコン
            if (!isTeacher) ...[
              noticeData.readStatus == 1
                  ? checkIcon
                  : unknownIcon,
            ],
          ],
        ),
      ),
    );
  }
}
