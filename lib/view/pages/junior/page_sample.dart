import 'package:flutter/material.dart';
import '././../../../constant/fonts.dart';

import '../../components/template/basic_template.dart';

class PageSample extends StatelessWidget {
  const PageSample({Key? key}) : super(key: key);

  final String title = 'さんぷる';
  @override
  Widget build(BuildContext context) {
    return BasicTemplate(title: title, children: const [
      Text('いどうしたよ', style: Fonts.h3),
    ]);
  }
}
