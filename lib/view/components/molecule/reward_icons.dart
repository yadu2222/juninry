import 'package:flutter/material.dart';
import '../../../constant/reward_icon.dart';
import '../../../constant/colors.dart';

class RewardIcons extends StatelessWidget {
  final void Function(int) choiceIconHandler;
  final List<bool> choiceIcon;
  const RewardIcons({super.key, required this.choiceIconHandler, required this.choiceIcon});

  @override
  Widget build(BuildContext context) {
    Widget iconButton(int index) {
      return InkWell(
        onTap: () {
          choiceIconHandler(index);
        },
        child: RewardIcon.getIcon(index, mainColor: AppColors.iconLight, iconColor: AppColors.main, size: 35, border: choiceIcon[index]),
      );
    }

    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [iconButton(0), iconButton(1), iconButton(2), iconButton(3), iconButton(4)],
      ),
      const SizedBox(height: 5),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [iconButton(5), iconButton(6), iconButton(7), iconButton(8), iconButton(9)],
      )
    ]);
  }
}
