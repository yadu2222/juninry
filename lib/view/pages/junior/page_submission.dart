import 'package:flutter/material.dart';

import '../../components/atoms/appbar.dart';
import '../../components/organism/submittion_list.dart';
import '../../components/molecule/homework_card.dart';

import '../../../models/homework_model.dart';
import '../../../constant/sample_data.dart'; // sampleData

// 提出ページ
class PageSubmissionJunior extends StatelessWidget {
  PageSubmissionJunior({super.key});

  final String title = '提出';

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(children: [
      AppBarView(titleText: title),
      HomeworkCard(homeworkData: SampleData.homeworkData[0]),
      const Expanded(child: SubmittionList()),
    ]));
  }
}
