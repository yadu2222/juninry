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
    return InkWell(
        onTap: () {
          debugPrint("noticeUUID: ${noticeData.noticeUUID}");
          isQuote
              ? context.go('/notice/register',
                  extra: {'quotedNoticeUUID': noticeData.noticeUUID})
              : context.go('/notice/detail',
                  extra: {'noticeUUID': noticeData.noticeUUID});
        },
        child: ListItem(
            padding:
                const EdgeInsets.only(top: 7, bottom: 10, left: 20, right: 20),
            // 表示する要素を配置
            widget: Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween, // Rowの子ウィジェットを左右に配置
              crossAxisAlignment:
                  CrossAxisAlignment.center, // Rowの子ウィジェットを中央に配置

              children: [
                Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start, // 子ウィジェットを左揃えに設定
                  children: [
                    Row(
                      children: [
                        // 日付け
                        Container(
                          child: Text(
                            noticeData.noticeDate!,
                            style: Fonts.h3,
                          ),
                        ),

                        //日時と学年のテキスト間のスペースを設定
                        const SizedBox(width: 15),

                        //学年
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
                    )
                  ],
                ),

                // アイコン
                Container(
                  alignment: Alignment.center,
                  child: Center(
                      child:
                          // 教師だったら既読ないよー
                          // isTeacher
                          //     ? null
                          //     :
                              noticeData.readStatus == null // 既読ステータスnullの人はお家ないのでアイコンなしで
                                  ? null
                                  : noticeData.readStatus == 1
                                      ? checkIcon
                                      : unknownIcon),
                ),
              ],
            )));
  }
}
