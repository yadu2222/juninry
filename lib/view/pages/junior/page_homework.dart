import 'package:flutter/material.dart';
import '././../../../constant/fonts.dart';
import '../../components/organism/basic_view.dart';

class PageHomeworkJunior extends StatelessWidget {
  const PageHomeworkJunior({Key? key}) : super(key: key);

  final String title = '宿題';

  @override
  Widget build(BuildContext context) {
    return BasicScreenView(
        title: '宿題',
        widget: Center(
          child: Text('しゅくだいもたくさん', style: Fonts.h2),
        ));
  }
}
