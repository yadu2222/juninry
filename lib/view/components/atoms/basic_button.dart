import 'package:flutter/material.dart';
import 'package:juninry/constant/colors.dart';
import 'package:juninry/constant/fonts.dart';

// TODO:活性と不活性をさ〜〜〜管理したいよな〜〜〜
class BasicButton extends StatelessWidget {
  const BasicButton(
      {super.key,
      this.text,
      this.icon,
      this.iconSize = 30,
      this.width = 0.475,
      required this.isColor, // trueでみどり falseで赤
      this.onPressed,
      this.height = 35.0,
      this.circular = 10,
      this.margin = const EdgeInsets.only(top: 5, bottom: 15)});

  final String? text;
  final IconData? icon;
  final double iconSize;
  final bool isColor;
  final double width;
  final double height;
  final double circular;
  final EdgeInsets margin;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
        width: screenWidth * width,
        height: height,
        margin: margin,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: isColor ? AppColors.subjectScience : AppColors.subjectJapanese,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(circular) //こちらを適用
                    )),
            onPressed: onPressed,
            child: Row(mainAxisSize: MainAxisSize.min, children: [
              icon != null ? Icon(icon, color: AppColors.iconLight, size: iconSize) : const SizedBox.shrink(),
              text != null
                  ? Expanded(
                      child: Container(
                          alignment: Alignment.center, // 残りのスペースの中央に配置
                          child: Text(
                            text!,
                            style: Fonts.h5w,
                          )))
                  : const SizedBox.shrink()
            ])));
  }
}
