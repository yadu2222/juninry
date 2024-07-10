import 'package:flutter/material.dart';

import '../../components/atoms/appbar.dart';
import '../../components/organism/homework_list.dart';
import '../../components/molecule/next_day_task.dart';

// import '../../../models/homework_model.dart';
import '../../../constant/sample_data.dart'; // sampleData


// TODO:api処理
class PageNextDayTaskJunior extends StatelessWidget {
  const PageNextDayTaskJunior({super.key});

  final String title = '提出';
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(children: [
        AppBarView(titleText: title),
        const NextDayTask(),
        Expanded(child: HomeworkList.classes(homeworkData: SampleData.apiHomeworkData)),
      ]),
    );
  }
}
