import 'package:flutter/material.dart';

import '../../../constant/fonts.dart';
import '../atoms/listitem.dart';

class NoticeCard extends StatelessWidget {
  const NoticeCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ListItem(
      height: 50.0,
      // ここに箱の中に表示したいウィジェットを入れる
      widget: Text(
        '最新のおしらせ',
        style: Fonts.p,
      ),
    );
  }
}