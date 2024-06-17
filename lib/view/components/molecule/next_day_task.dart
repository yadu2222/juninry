import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';

import '../../../constant/fonts.dart';
import '../atoms/listitem.dart';
import './progress_bar.dart';

// 提出ページ見出し
class NextDayTask extends StatelessWidget {
  const NextDayTask({super.key, this.widget, this.margin = const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10)});

  final String message = 'キメラ先生からのコメント';
  final double progress = 0.5; // TODO:進捗バーの進捗度 値をもらいたい 今は定数
  final Widget? widget; // 進捗バーの下に表示するウィジェット
  final EdgeInsetsGeometry margin;

  @override
  Widget build(BuildContext context) {
    return ListItem(
        margin: margin,
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          top: 15,
          bottom: 15,
        ),
        widget: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // 左寄せ
            children: [
              const Text('明日までの宿題', style: Fonts.h1),
              Text(message, style: Fonts.p), // キメラ先生からのコメント
              ProgressBar(progress: progress), // 進捗バー
              if (widget != null) widget!, // 進捗バーの下に表示するウィジェット
            ]));
  }
}
