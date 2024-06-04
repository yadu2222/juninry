import 'package:flutter/material.dart';

import '../../components/atoms/appbar.dart';
import '../../components/organism/latest_notice_tab.dart';
import '../../components/organism/junior_shortcuts.dart';
import '../../components/organism/homework_tab.dart';

class PageHomeJunior extends StatelessWidget {
  PageHomeJunior({Key? key}) : super(key: key);

  final String title = 'ホーム';

  @override
  Widget build(BuildContext context) {
    return Center(child: Column(children: [AppBarView(titleText: title), LatestNoticeTab(), TaskTab(), JuniorShortcuts()]));
  }
}
