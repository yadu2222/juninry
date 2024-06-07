import 'package:flutter/material.dart';
import '././../../../constant/fonts.dart';

import '../../components/template/basic_template.dart';

class PageNoticeJunior extends StatelessWidget {
  const PageNoticeJunior({super.key});

  final String title = 'おしらせ';
  @override
  Widget build(BuildContext context) {
    return BasicTemplate(title: title, children: const [
      Text('おしらせがたくさん', style: Fonts.h3),
    ]);
  }
}
