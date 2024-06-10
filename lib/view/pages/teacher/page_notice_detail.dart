import 'package:flutter/material.dart';
import 'package:juninry/constant/sample_data.dart';
import 'package:juninry/view/components/atoms/appbar.dart';
import 'package:juninry/view/components/atoms/listitem.dart';
import 'package:juninry/view/components/molecule/notice_detail_tab.dart';
import 'package:juninry/view/components/organism/student_list.dart';
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
          AppBarView(
              titleText: title,
              popIconButton: true, // 戻るボタン
              featureIconButton: IconButton(
                  onPressed: () {}, // 遷移処理
                  icon: const Icon(
                    Icons.attach_file, // 右側のアイコン
                    size: 30,
                  ))), // app bar
          // 最新のお知らせ
          NoticeDetailTab(tabData: sample),
          // 明日までの宿題
          const DividerView(
            icon: Icons.menu_book_outlined,
            title: '確認状況',
          ),
          Expanded(
              // リストビューは高さ制限を付けないと実行時エラーが出る
              child: StudentList(studentData: SampleData.studentData // ここではサンプルのList<map>を渡している
                  )) // 確認された学生諸君
        ],
      ),
    );
  }
}
