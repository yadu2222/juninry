import 'package:flutter/material.dart';
import 'package:juninry/view/components/molecule/notice_card.dart';
import 'package:juninry/view/components/organism/notice_list.dart';
import '././../../../constant/fonts.dart';

import '../../components/template/basic_template.dart';

class PageNoticeJunior extends StatelessWidget {
  const PageNoticeJunior({super.key});

  final String title = 'おしらせ';
  @override
  Widget build(BuildContext context) {
    return Center(
          child: Column(children: [ 
            AppBarView(titleText: title),
            Text('おしらせがたくさん', style: Fonts.h3),
          ])
        );
  }
}
