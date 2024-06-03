import 'package:flutter/material.dart';

import '../../components/atoms/appbar.dart';
import '../../components/organism/task_list.dart';
import '../../components/molecule/progress_bar.dart';
import '../../components/molecule/divider.dart';

class PageHomeworkJunior extends StatelessWidget {
  const PageHomeworkJunior({Key? key}) : super(key: key);

  final String title = '課題一覧';
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(children: [
        AppBarView(titleText: title),
        // const Text('しゅくだいもたくさん', style: Fonts.h2),
        const ProgressBar(progress: 0.2),
        // newExoandedでラップするとサイズを自動調整してくれるようになる
        // べんり〜〜！！！
        DividerView(
          icon: Icons.menu_book_outlined,
          title: 'test',
        ),
        const Expanded(child: TaskList()),
      ]),
    );
  }
}
