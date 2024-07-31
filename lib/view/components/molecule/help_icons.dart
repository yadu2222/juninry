import 'package:flutter/material.dart';
import '../../../constant/help_icon.dart';
import '../../../constant/colors.dart';

class HelpIcons extends StatelessWidget {
  final void Function(int) choiceIconHandler;
  final List<bool> choiceIcon;
  const HelpIcons({super.key, required this.choiceIconHandler, required this.choiceIcon});

  @override
  Widget build(BuildContext context) {
    Widget iconButton(int index) {
      return InkWell(
        onTap: () {
          choiceIconHandler(index);
        },
        child: HelpIcon.getIcon(index, mainColor: AppColors.iconLight, iconColor: AppColors.main, size: 35, border: choiceIcon[index]),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [iconButton(0), iconButton(1), iconButton(2), iconButton(3), iconButton(4)],
    );
  }
}
