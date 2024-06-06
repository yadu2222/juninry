import 'package:flutter/material.dart';
import '../../../constant/fonts.dart';

// タイトルと区切り線
class DividerView extends StatelessWidget {
  const DividerView({Key? key, this.icon, this.title, this.dividColor = Colors.white, this.indent = 20, this.endIndent = 20, this.dividWeight = 1.5}) : super(key: key);

  // null許容
  final IconData? icon; // 表示したいアイコン
  final String? title; // タイトル
  final Color dividColor; // 線の色
  final double indent; // 線の左の空白
  final double endIndent; // 線の右の空白
  final double dividWeight;

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
      Divider(thickness: dividWeight, indent: indent, endIndent: endIndent, color: dividColor)
    ]);
  }
}
