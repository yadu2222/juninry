import 'package:flutter/material.dart';
import 'package:juninry/view/components/molecule/notice_card.dart';
import 'package:juninry/view/components/organism/notice_list.dart';
import '././../../../constant/fonts.dart';

import '../../components/atoms/appbar.dart';

class PageNoticeJunior extends StatelessWidget {
  const PageNoticeJunior({Key? key}) : super(key: key);

  final String title = 'おしらせ';
  @override
  Widget build(BuildContext context) {
    return Center(
          child: Column(children: [ 
            AppBarView(titleText: title),
            const Expanded(child: NoticeList()),
          ])
        );
  }
}
