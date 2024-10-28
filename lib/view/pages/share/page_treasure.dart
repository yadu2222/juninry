import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:juninry/constant/fonts.dart';
import 'package:juninry/models/treasure_model.dart';

import '../../components/template/basic_template.dart';

class PageTreasure extends HookWidget {
  final Treasure treasure;
  const PageTreasure({
    super.key,
    required this.treasure,
  });

  final String title = 'たからばこ';

  Future<void> open() async {
    // たからばこを開く処理
  }

  @override
  Widget build(BuildContext context) {
    // テンプレート呼び出し
    return BasicTemplate(title: title, children: [
      const Spacer(),
      const Text("たからばこをタップしてね", style: Fonts.h4w),
      const Spacer(),
      InkWell(
          onTap: () {
            open();
          },
          child: Container(
            width: 300,
            height: 300,
            padding: const EdgeInsets.all(10),
            child: Image.asset("assets/images/close_treasure.png", fit: BoxFit.cover),
          ))
    ]);
  }
}
