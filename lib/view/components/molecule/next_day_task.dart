import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';

import '../../../constant/fonts.dart';
import '../atoms/listitem.dart';
import './progress_bar.dart';

// 提出ページ見出し
class NextDayTask extends StatelessWidget {
  const NextDayTask({super.key, this.widget});

  final String message = 'キメラ先生からのコメント';
  final double progress = 0.5;  // TODO:進捗バーの進捗度 値をもらいたい 今は定数
  final Widget? widget;         // 進捗バーの下に表示するウィジェット

  @override
  Widget build(BuildContext context) {
    return ListItem(
        margin: const EdgeInsets.only(top: 10, bottom: 15),
        padding: const EdgeInsets.only(
          left: 15,
          right: 15,
          top: 10,
          bottom: 10,
        ),
        widget: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // 左寄せ
            children: [
              const Text('明日までの宿題', style: Fonts.h1),
              Text(message, style: Fonts.p),
              ProgressBar(progress: progress),
              if (widget != null) widget!,
            ]));
  }
}
