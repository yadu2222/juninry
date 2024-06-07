import 'package:flutter/material.dart';

// import '../../../models/homework_model.dart';
import '../../components/template/basic_template.dart';
import '../../components/organism/homework_list.dart';
import '../../components/molecule/progress_bar.dart';
import '../../components/molecule/divider.dart';

import '../../../constant/sample_data.dart'; // sampleData

class PageHomeworkJunior extends StatelessWidget {
  const PageHomeworkJunior({super.key});

  final String title = '課題一覧'; // appbarのタイトル
  final double progress = 0.2; // 進捗率
  // 区切り線のプロパティ
  final IconData icon = Icons.menu_book_outlined;
  final String divideTitle = 'test';

  @override
  Widget build(BuildContext context) {
    return BasicTemplate(title: title, children: [
      ProgressBar(progress: progress),
      // newExoandedでラップするとサイズを自動調整してくれるようになる
      // べんり〜〜！！！
      DividerView(
        icon: icon,
        title: divideTitle,
      ),
      Expanded(child: HomeworkList(homeworkData: SampleData.homeworkData,)),
    ]);
  }
}
