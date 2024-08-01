import 'package:flutter/material.dart';
import './colors.dart';

class RewardIcon {
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
    Icons.icecream, // あいす
    Icons.cake, // おかし
    Icons.local_dining, // ごはん
    Icons.sports_baseball, // ボールなど
    Icons.rocket_launch, // おもちゃ
    Icons.menu_book_rounded, // 本
    Icons.checkroom, // ようふく
    Icons.local_movies_rounded, // えいが
    Icons.card_travel_outlined, // りょこう
    Icons.money, // おこづかい
  ];
}
