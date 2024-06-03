import 'package:flutter/material.dart';
import '../../../constant/fonts.dart';

// タイトルと区切り線
class DividerView extends StatelessWidget {
  const DividerView({Key? key, this.icon, this.title}) : super(key: key);

  // null許容
  final IconData? icon; // 表示したいアイコン
  final String? title; // タイトル

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(children: [
        Container(
          margin: const EdgeInsets.only(left: 25),
          child: icon != null
              ? Icon(
                  icon!,
                  color: Colors.white,
                  size: 30,
                )
              : const SizedBox.shrink(),
        ),
        Container(margin: const EdgeInsets.only(left: 10), child: title != null ? Text(title!, style: Fonts.h2w) : const SizedBox.shrink())
      ]),
      const Divider(
        thickness: 1.5,
        indent: 20,
        endIndent: 20,
        color: Colors.white,
      )
    ]);
  }
}
