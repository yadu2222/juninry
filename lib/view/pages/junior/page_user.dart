import 'package:flutter/material.dart';
import '././../../../constant/fonts.dart';

import '../../components/atoms/appbar.dart';

class PageUserDataJunior extends StatelessWidget {
  const PageUserDataJunior({Key? key}) : super(key: key);

final String title = 'ユーザー';
  @override
  Widget build(BuildContext context) {
    return Center(
          child: Column(children: [ 
            AppBarView(titleText: title),Text('設定画面ともいう まよう', style: Fonts.h3),])
    );
  }
}
