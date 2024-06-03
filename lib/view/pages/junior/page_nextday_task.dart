import 'package:flutter/material.dart';

import '../../components/atoms/appbar.dart';
import '../../components/organism/task_list.dart';
import '../../components/molecule/next_day_task.dart';
import '../../components/molecule/divider.dart';

class PageNextDayTaskJunior extends StatelessWidget {
  const PageNextDayTaskJunior({Key? key}) : super(key: key);

  final String title = '提出';
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(children: [
        AppBarView(titleText: title),
        NextDayTask(),
        const DividerView(
          icon: Icons.menu_book_outlined,
          title: 'test',
        ),
        const Expanded(child: TaskList()),
      ]),
    );
  }
}
