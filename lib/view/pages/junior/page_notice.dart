import 'package:flutter/material.dart';
import '././../../../constant/fonts.dart';
import '../../components/organism/basic_view.dart';

class PageNoticeJunior extends StatelessWidget {
  const PageNoticeJunior({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BasicScreenView(
        title: 'おしらせ',
        widget: Center(
          child: Text('おしらせがたくさん', style: Fonts.h2),
        ));
  }
}
