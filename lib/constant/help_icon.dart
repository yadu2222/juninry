import 'package:flutter/material.dart';
import './colors.dart';

class HelpIcon {
  // お手伝いのアイコンを取得
  static Container getIcon(int index) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.main,
        borderRadius: BorderRadius.circular(30),
      ),
      padding: const EdgeInsets.all(4),
      child: Icon(
        helpIcons[index],
        color: AppColors.iconLight,
        size: 20,
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
