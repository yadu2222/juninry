import 'package:flutter/material.dart';
import '././../../../constant/fonts.dart';

import '../../components/atoms/appbar.dart';

class PageHomeworkJunior extends StatelessWidget {
  const PageHomeworkJunior({Key? key}) : super(key: key);

  final String title = '宿題';
  @override
  Widget build(BuildContext context) {
    return Center(
          child: Column(children: [ 
            AppBarView(titleText: title),
            const Text('しゅくだいもたくさん', style: Fonts.h2),])
        );
  }
}
