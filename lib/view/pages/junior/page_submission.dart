import 'package:flutter/material.dart';

import '../../components/atoms/appbar.dart';
import '../../components/organism/submittion_list.dart';
import '../../components/molecule/homework_card.dart';

// 提出ページ
class PageSubmissionJunior extends StatelessWidget {
  const PageSubmissionJunior({super.key});

  final String title = '提出';
  // final Map taskData ;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(children: [
      AppBarView(titleText: title),
      HomeworkCard(taskData: {},),
      const Expanded(child: SubmittionList()),
    ]));
  }
}
