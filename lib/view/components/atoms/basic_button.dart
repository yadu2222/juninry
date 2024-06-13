import 'package:flutter/material.dart';
import 'package:juninry/constant/colors.dart';
import 'package:juninry/constant/fonts.dart';

// TODO:活性と不活性をさ〜〜〜管理したいよな〜〜〜
class BasicButton extends StatelessWidget {
  const BasicButton({
    super.key,
    required this.text,
    this.icon,
    this.width = 0.475,
    required this.isColor, // trueでみどり falseで赤
    this.onPressed,
  });

  final String text;
  final IconData? icon;
  final bool isColor;
  final double width;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
        width: screenWidth * width,
        margin: const EdgeInsets.only(top: 5, bottom: 15),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: isColor ? AppColors.subjectScience : AppColors.subjectJapanese),
            onPressed: onPressed,
            child: Row(mainAxisSize: MainAxisSize.min, children: [
              icon != null ? Icon(icon, color: AppColors.iconLight, size: 30) : const SizedBox.shrink(),
              Expanded(
                  child: Container(
                      alignment: Alignment.center, // 残りのスペースの中央に配置
                      child: Text(
                        text,
                        style: Fonts.h4w,
                      )))
            ])));
  }
}
