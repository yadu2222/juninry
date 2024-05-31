import 'package:flutter/material.dart';
import '././../../../constant/fonts.dart';
import '../../components/organism/basic_view.dart';

class PageSample extends StatelessWidget {
  const PageSample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BasicScreenView(
        title: 'さんぷる',
        widget: Center(
          child: Text('いどうしたよ', style: Fonts.h2),
        ));
  }
}
