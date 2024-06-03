import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '././../../../constant/fonts.dart';

import '../../components/atoms/appbar.dart';
import '../../components/organism/student_list.dart';
import '../../components/organism/task_list.dart';

class PageHomeJunior extends StatelessWidget {
  PageHomeJunior({Key? key}) : super(key: key);

  final String title = 'ホーム';

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(children: [
      AppBarView(titleText: title),
      ElevatedButton(
        onPressed: () {
          // 画面遷移
          context.push('/sample');
        },
        child: const Text(
          '遷移するよ',
          style: Fonts.h2,
        ),
      ),

      // newExoandedでラップするとサイズを自動調整してくれるようになる
      // べんり〜〜！！！
      new Expanded(child: TaskList())
    ]));
  }
}
