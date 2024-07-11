import 'package:flutter/material.dart';

import '././../../../constant/fonts.dart';
import '././../../../constant/colors.dart';
import 'package:go_router/go_router.dart';

// ショートカットボタン
// 遷移する
class ShortcutButton extends StatelessWidget {
  const ShortcutButton({Key? key, required this.title, required this.icon, required this.movePage}) : super(key: key);

  final String title; // ボタンのタイトル
  final IconData icon; // ボタンを押したときのアイコン
  final String movePage; // 遷移先のパス

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
        width: width * 0.45,
        margin: const EdgeInsets.only(bottom: 5, right: 5, left: 5),
        child: ElevatedButton(
          onPressed: () {
            context.go(movePage);
          },
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              backgroundColor: AppColors.iconLight),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: AppColors.main,
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.all(4),
                child: Icon(
                  icon,
                  color: AppColors.iconLight,
                  size: 20,
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.center, // 残りのスペースの中央に配置
                  child: Text(title, style: Fonts.py),
                ),
              ),
            ],
          ),
        ));
  }
}
