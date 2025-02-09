import 'package:flutter/material.dart';
import 'colors.dart';

class Fonts {
  // タイトル用フォント
  static const TextStyle titleFont = TextStyle(fontSize: 22, fontFamily: 'Noto Sans JP', color: AppColors.iconLight, fontWeight: FontWeight.bold);

  // 文章
  static const TextStyle h1 = TextStyle(fontSize: 28, fontFamily: 'Noto Sans JP', color: AppColors.font, fontWeight: FontWeight.normal);
  static const TextStyle h2 = TextStyle(fontSize: 24, fontFamily: 'Noto Sans JP', color: AppColors.font, fontWeight: FontWeight.bold);
  static const TextStyle h3 = TextStyle(fontSize: 20, fontFamily: 'Noto Sans JP', color: AppColors.font, fontWeight: FontWeight.bold);
  static const TextStyle h4 = TextStyle(fontSize: 18, fontFamily: 'Noto Sans JP', color: AppColors.font, fontWeight: FontWeight.bold);
  static const TextStyle h5 = TextStyle(fontSize: 16, fontFamily: 'Noto Sans JP', color: AppColors.font, fontWeight: FontWeight.bold);

  static const TextStyle p = TextStyle(fontSize: 15, fontFamily: 'Noto Sans JP', color: AppColors.font, fontWeight: FontWeight.bold);

  // 白文字用
  static const TextStyle h1w = TextStyle(fontSize: 28, fontFamily: 'Noto Sans JP', color: AppColors.iconLight, fontWeight: FontWeight.bold);
  static const TextStyle h2w = TextStyle(fontSize: 24, fontFamily: 'Noto Sans JP', color: AppColors.iconLight, fontWeight: FontWeight.bold);
  static const TextStyle h3w = TextStyle(fontSize: 20, fontFamily: 'Noto Sans JP', color: AppColors.iconLight, fontWeight: FontWeight.bold);
  static const TextStyle h4w = TextStyle(fontSize: 18, fontFamily: 'Noto Sans JP', color: AppColors.iconLight, fontWeight: FontWeight.bold);
  static const TextStyle h5w = TextStyle(fontSize: 16, fontFamily: 'Noto Sans JP', color: AppColors.iconLight, fontWeight: FontWeight.bold);
  static const TextStyle pw = TextStyle(fontSize: 14, fontFamily: 'Noto Sans JP', color: AppColors.iconLight, fontWeight: FontWeight.bold);
  // static const TextStyle bw = TextStyle(fontSize: 13, fontFamily: 'Noto Sans JP', color: AppColors.iconLight, fontWeight: FontWeight.bold);

  // 警告？
  static const TextStyle h1r = TextStyle(fontSize: 14, fontFamily: 'Noto Sans JP', color: AppColors.buttonCheck, fontWeight: FontWeight.bold);
  static const TextStyle pr = TextStyle(fontSize: 14, fontFamily: 'Noto Sans JP', color: AppColors.dialogNegative, fontWeight: FontWeight.bold);

  // 青文字
  static const TextStyle pb = TextStyle(fontSize: 14, fontFamily: 'Noto Sans JP', color: AppColors.dialogPositive, fontWeight: FontWeight.bold);

  // グレー
  static const TextStyle h4g = TextStyle(fontSize: 18, fontFamily: 'Noto Sans JP', color: AppColors.dialogNeutral, fontWeight: FontWeight.bold);
  static const TextStyle pg = TextStyle(fontSize: 14, fontFamily: 'Noto Sans JP', color: AppColors.dialogNeutral, fontWeight: FontWeight.bold);

  // そんなに目立たない
  static const TextStyle h1y = TextStyle(fontSize: 28, fontFamily: 'Noto Sans JP', color: AppColors.fontLight, fontWeight: FontWeight.bold);
  static const TextStyle h2y = TextStyle(fontSize: 24, fontFamily: 'Noto Sans JP', color: AppColors.fontLight, fontWeight: FontWeight.bold);
  static const TextStyle h3y = TextStyle(fontSize: 20, fontFamily: 'Noto Sans JP', color: AppColors.fontLight, fontWeight: FontWeight.bold);
  static const TextStyle h4y = TextStyle(fontSize: 18, fontFamily: 'Noto Sans JP', color: AppColors.fontLight, fontWeight: FontWeight.bold);
  static const TextStyle py = TextStyle(fontSize: 14, fontFamily: 'Noto Sans JP', color: AppColors.fontLight, fontWeight: FontWeight.bold);
  // static const TextStyle by = TextStyle(fontSize: 14, fontFamily: 'Noto Sans JP', color: AppColors.fontLight, fontWeight: FontWeight.bold);

  // お知らせ一覧のために
  static const TextStyle notice = TextStyle(fontSize: 16, fontFamily: 'Noto Sans JP', color: AppColors.font, fontWeight: FontWeight.bold, height: 1.0);

  // ポイント
  static const TextStyle point = TextStyle(fontSize: 20, fontFamily: 'Noto Sans JP', color: AppColors.font, fontWeight: FontWeight.bold);
  static const TextStyle totalPoint = TextStyle(fontSize: 20, fontFamily: 'Noto Sans JP', color: AppColors.fontLight, fontWeight: FontWeight.bold);
}
