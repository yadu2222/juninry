import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../components/atoms/appbar.dart';
import '../../components/organism/latest_notice_tab.dart';
import '../../components/molecule/next_day_task.dart';
import '../../components/organism/junior_shortcuts.dart';

class PageHomeJunior extends StatelessWidget {
  PageHomeJunior({Key? key}) : super(key: key);

  final String title = 'ホーム';

  @override
  Widget build(BuildContext context) {
    return Center(child: Column(children: [AppBarView(titleText: title), LatestNoticeTab(), NextDayTask(), JuniorShortcuts()]));
  }
}
