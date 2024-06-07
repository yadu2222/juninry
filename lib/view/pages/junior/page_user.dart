import 'package:flutter/material.dart';
import '././../../../constant/fonts.dart';

import '../../components/template/basic_template.dart';

class PageUserDataJunior extends StatelessWidget {
  const PageUserDataJunior({super.key});

  final String title = 'ユーザー';
  @override
  Widget build(BuildContext context) {
    return BasicTemplate(title: title, children: const [
      Text('ユーザー情報', style: Fonts.h3),
    ]);
  }
}
