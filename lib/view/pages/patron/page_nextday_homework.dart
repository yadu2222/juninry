import 'package:flutter/material.dart';

import '../../components/atoms/appbar.dart';
import '../../components/organism/homework_list.dart';
import '../../components/molecule/next_day_task.dart';
import '../../components/molecule/divider.dart';

import '../../../constant/sample_data.dart'; // sampleData

class PageNextDayHomeworkPatron extends StatelessWidget {
  const PageNextDayHomeworkPatron({super.key});

  final String title = '提出状況';
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(children: [
        AppBarView(titleText: title),
        Text(SampleData.juniorUser.userName),
        const NextDayTask(),
        const DividerView(
          icon: Icons.menu_book_outlined,
          title: 'test',
        ),
        Expanded(child: HomeworkList.limit(homeworkData: SampleData.homeworkData)),
      ]),
    );
  }
}
