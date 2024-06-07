import 'package:flutter/material.dart';

import '../../components/organism/submittion_list.dart';
import '../../components/molecule/homework_card.dart';

// import '../../../models/homework_model.dart';
import '../../components/template/basic_template.dart';
import '../../../constant/sample_data.dart'; // sampleData

// 提出ページ
class PageSubmissionJunior extends StatelessWidget {
  const PageSubmissionJunior({super.key});

  final String title = '提出';

  @override
  Widget build(BuildContext context) {
    // テンプレート呼び出し
    return BasicTemplate(title: title, children: [
      HomeworkCard(homeworkData: SampleData.homeworkData[0]), // 課題カード
      const Expanded(child: SubmittionList()),    // 提出リスト
    ]);
  }
}
