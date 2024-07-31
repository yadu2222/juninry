import 'package:flutter/material.dart';
import '../../../constant/fonts.dart';

// タイトルと区切り線
class DividerView extends StatelessWidget {
  const DividerView({Key? key, this.icon, this.endIcon, this.title, this.fontStyle = Fonts.h3w, this.dividColor = Colors.white, this.indent = 20, this.endIndent = 20, this.dividWeight = 1.5}) : super(key: key);

  // null許容
  final IconData? icon; // 表示したいアイコン
  final InkWell? endIcon; // 表示したいアイコン iconbuttonってなんであんなマージとるんですかね
  final String? title; // タイトル
  final TextStyle fontStyle;
  final Color dividColor; // 線の色
  final double indent; // 線の左の空白
  final double endIndent; // 線の右の空白
  final double dividWeight; // ふとさ

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(children: [
        Container(
          margin: EdgeInsets.only(left: indent),
          child: icon != null
              ? Icon(
                  icon!,
                  color: Colors.white,
                  size: 30,
                )
              : const SizedBox.shrink(),
        ),
        Container(margin: const EdgeInsets.only(left: 10), child: title != null ? Text(title!, style: fontStyle) : const SizedBox.shrink()),
        endIcon != null
            ? Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [Container(margin: EdgeInsets.only(left: endIndent), child: endIcon)],
              )
            : const SizedBox.shrink()
      ]),
      Divider(thickness: dividWeight, indent: indent, endIndent: endIndent, color: dividColor)
    ]);
  }
}
