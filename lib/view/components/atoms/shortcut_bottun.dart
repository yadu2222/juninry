import 'package:flutter/material.dart';

import '././../../../constant/fonts.dart';
import '././../../../constant/colors.dart';
import 'package:go_router/go_router.dart';

class ShortcutButton extends StatelessWidget {
  const ShortcutButton({Key? key, required this.title, required this.icon, required this.movePage}) : super(key: key);

  final String title;
  final IconData icon;
  final String movePage;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
        width: width * 0.45,
        margin: EdgeInsets.only(bottom: 5, right: 5, left: 5),
        child: ElevatedButton(
          onPressed: () {
            context.go(movePage);
          },
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Row(
            children: [
              Icon(icon, color: AppColors.main),
              Expanded(
                child: Container(
                  alignment: Alignment.center, // 残りのスペースの中央に配置
                  child: Text(title, style: Fonts.h4y),
                ),
              ),
            ],
          ),
        ));
  }
}
