import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

// view
import '../../components/template/scroll_template.dart';

class PageOuchiPatron extends HookWidget {
  const PageOuchiPatron({super.key});

  final String title = 'おうち';
  @override
  Widget build(BuildContext context) {
    return ScrollTemplate(title: title, children: [
      // ここにおうちのコンテンツを追加
      // たまっているポイント
      // GHOUBI交換所あるよという主張
      // おてつだい一覧(デイリーミッションなかんじ)
    ]);
  }
}
