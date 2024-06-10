import 'package:flutter/material.dart';

import '../../components/organism/submittion_list.dart';
import '../../components/molecule/homework_card.dart';
import '../../components/molecule/divider.dart';

// import '../../../models/homework_model.dart';
import '../../components/template/basic_template.dart';
import '../../../constant/sample_data.dart'; // sampleData

// 提出ページ
class PageSubmissionJunior extends StatelessWidget {
  const PageSubmissionJunior({
    super.key,
    required this.homeworkUUId,
  });

  final String title = '提出';
  // TODO: ここでIDを元に提出が必要な課題データを取得する処理を追加
  final String homeworkUUId;

  @override
  Widget build(BuildContext context) {
    // テンプレート呼び出し
    return BasicTemplate(title: title, children: [
      HomeworkCard(homeworkData: SampleData.homeworkData[0]), // 課題カード
      const DividerView(),    // 区切り線
      // 提出リスト
      Expanded(
          child: SubmittionList(
        homeworkData: SampleData.homeworkData[0],
      )), // 提出リスト
    ]);
  }
}
