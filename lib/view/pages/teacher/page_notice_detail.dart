import 'package:flutter/material.dart';
import 'package:juninry/constant/sample_data.dart';

import '../../components/template/basic_template.dart';
import 'package:juninry/view/components/molecule/notice_detail_tab.dart';
import 'package:juninry/view/components/organism/student_list.dart';
import '../../components/molecule/divider.dart';

class PageNoticeDetailTeacher extends StatelessWidget {
  const PageNoticeDetailTeacher({super.key});

  // fields
  final String title = "おしらせ詳細";

  @override
  Widget build(BuildContext context) {
    return BasicTemplate(

      // app barのプロパティ
        title: title,
        popIcon: true, // 戻るボタン
        featureIconButton: IconButton(
            onPressed: () {}, // 遷移処理
            icon: const Icon(
              Icons.attach_file, // 右側のアイコン
              size: 30,
            )),
        children: [
          // なかみ
          NoticeDetailTab(tabData: SampleData.noticesData[0]),  // 詳細
          // 明日までの宿題
          const DividerView(
            icon: Icons.menu_book_outlined,
            title: '確認状況',
          ),
           // お知らせを確認した学生諸君
          Expanded(
              // リストビューは高さ制限を付けないと実行時エラーが出る
              child: StudentList(studentData: SampleData.studentData // ここではサンプルのList<map>を渡している
                  ))
        ]);
  }
}
