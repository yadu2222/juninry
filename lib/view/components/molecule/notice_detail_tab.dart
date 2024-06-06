// おしらせ詳細タブ

import 'package:flutter/material.dart';
import 'package:juninry/view/components/atoms/listitem.dart';

class NoticeDetailTab extends StatelessWidget {
  const NoticeDetailTab({super.key, required this.tabData});

  // fields
  final Map tabData;

  @override
  Widget build(BuildContext context) {
    return ListItem(
        widget: Column(
      children: [
        Row(
          children: [
            // 日付
            // クラス名
          ],
        ),
        // おてがみのタイトル
        // バー
        // 本文
      ],
    ));
  }
}
