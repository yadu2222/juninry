import 'package:flutter/material.dart';
import '././../../../constant/fonts.dart';
import '../../components/organism/basic_view.dart';

class PageUserDataJunior extends StatelessWidget {
  const PageUserDataJunior({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BasicScreenView(
        title: 'ユーザーデータ',
        widget: Center(
          child: Text('設定画面ともいう まよう', style: Fonts.h2),
        ));
  }
}