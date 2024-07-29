import 'package:flutter/material.dart';
import './colors.dart';

class HelpIcon {
  // お手伝いのアイコンを取得
  static Container getIcon(int index, {Color mainColor = AppColors.main, Color iconColor = AppColors.iconLight, double size = 20, bool border = false}) {
    return Container(
      decoration: BoxDecoration(
        color: mainColor,
        borderRadius: BorderRadius.circular(30),
        border: border ? Border.all(color: AppColors.subjectJapanese, width: 3) : Border.all(color: iconColor, width: 3),
      ),
      padding: const EdgeInsets.all(4),
      child: Icon(
        helpIcons[index],
        color: iconColor,
        size: size,
      ),
    );
  }

  // ここからお手伝いのアイコンを選んでもらうことで、
  // 配列の要素数をdbで保存すれば引き出すことができる
  static List<IconData> helpIcons = [
    Icons.bathtub, // おふろ
    Icons.cleaning_services, // そうじ
    Icons.local_laundry_service, // せんたく
    Icons.shopping_cart, // かいもの
    Icons.local_dining, // 料理
  ];
}
