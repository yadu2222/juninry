import 'package:flutter/material.dart';
import 'colors.dart';

class Fonts {
  // タイトル用フォント
  static const TextStyle titleFont = TextStyle(fontSize: 26, fontFamily: 'Noto Sans JP', color: AppColors.iconLight, fontWeight: FontWeight.bold);

  // 文章
  static const TextStyle h1 = TextStyle(fontSize: 28, fontFamily: 'Noto Sans JP', color: AppColors.font, fontWeight: FontWeight.bold);
  static const TextStyle h2 = TextStyle(fontSize: 20, fontFamily: 'Noto Sans JP', color: AppColors.font, fontWeight: FontWeight.bold);
  static const TextStyle h3 = TextStyle(fontSize: 18, fontFamily: 'Noto Sans JP', color: AppColors.font, fontWeight: FontWeight.bold);
  static const TextStyle p = TextStyle(fontSize: 15, fontFamily: 'Noto Sans JP', color: AppColors.font, fontWeight: FontWeight.bold);

  // 白文字用
   static const TextStyle h1w = TextStyle(fontSize: 28, fontFamily: 'Noto Sans JP', color: AppColors.iconLight, fontWeight: FontWeight.bold);
  static const TextStyle h2w = TextStyle(fontSize: 20, fontFamily: 'Noto Sans JP', color: AppColors.iconLight, fontWeight: FontWeight.bold);
  static const TextStyle h3w = TextStyle(fontSize: 18, fontFamily: 'Noto Sans JP', color: AppColors.iconLight, fontWeight: FontWeight.bold);
  static const TextStyle pw = TextStyle(fontSize: 15, fontFamily: 'Noto Sans JP', color: AppColors.iconLight, fontWeight: FontWeight.bold);
}
