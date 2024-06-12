import 'package:flutter/material.dart';
import 'package:juninry/constant/colors.dart';
import 'package:juninry/constant/fonts.dart';


// TODO:活性と不活性をさ〜〜〜管理したいよな〜〜〜
class BasicButton extends StatelessWidget {
  const BasicButton({
    super.key,
    required this.text,
    required this.isColor, // trueでみどり falseで赤
    this.onPressed,
  });

  final String text;
  final bool isColor;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 5, bottom: 15),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: isColor ? AppColors.subjectScience : AppColors.subjectJapanese),
            onPressed: onPressed,
            child: Text(
              text,
              style: Fonts.h4w,
            )));
  }
}
