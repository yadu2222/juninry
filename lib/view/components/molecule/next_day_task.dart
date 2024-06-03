import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../constant/fonts.dart';
import '../atoms/listitem.dart';
import './progress_bar.dart';

// 提出ページ見出し
class NextDayTask extends StatelessWidget {
  NextDayTask({Key? key}) : super(key: key);

  final String message = 'キメラ先生からのコメント';
  double progress = 0.5;

  @override
  Widget build(BuildContext context) {
    return ListItem(
        margin: const EdgeInsets.only(top: 10, bottom: 15),
        padding: const EdgeInsets.only(
          left: 15,
          right: 15,
          top: 15,
        ),
        height: 130,
        // ここに箱の中に表示したいウィジェットを入れる
        widget: Column(
            crossAxisAlignment: CrossAxisAlignment.start, //これをつける
            children: [
              const Text('明日までの宿題', style: Fonts.h1),
              Text(message, style: Fonts.p),
              ProgressBar(progress: progress),
            ]));
  }
}
