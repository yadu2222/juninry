import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../constant/fonts.dart';
import '../../../constant/colors.dart';

class ConItem extends StatelessWidget {
  const ConItem({super.key, required this.iconData, required this.title, required this.movePage});

  final IconData iconData;
  final String title;
  final String movePage; // 遷移先のパス

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          context.go(movePage);
        },
        child: SizedBox(
            child: Column(children: [
          Icon(
            iconData,
            color: AppColors.iconLight,
            size: 30,
          ),
          Text(
            title,
            style: Fonts.pw,
          )
        ])));
  }
}
