import 'package:flutter/material.dart';
import 'package:juninry/view/components/atoms/appbar.dart';
import 'package:juninry/view/components/atoms/listitem.dart';
import 'package:juninry/view/components/molecule/notice_detail_tab.dart';
import '../../components/molecule/divider.dart';

class PageNoticeDetail extends StatelessWidget {
  PageNoticeDetail({super.key});

  // fields
  final String title = "おしらせ詳細";

  // sample
  final Map sample = {
    "noticeDate": "2025.6.6", // 日付
    "className": "3-A", // クラスの名前
    "noticeTitle": "夏休みの宿題について", // タイトル
    "noticeExplanatory": "最終日まで残さないように。\n二行目だよ。", // 本文
  };

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          AppBarView(titleText: title), // app bar  // TODO: リンクアイコン

          // 最新のお知らせ
          NoticeDetailTab(tabData: sample),
          // 明日までの宿題  TODO: バー
          DividerView(
            icon: Icons.menu_book_outlined,
            title: '確認状況',
          ),
        ],
      ),
    );
  }
}
