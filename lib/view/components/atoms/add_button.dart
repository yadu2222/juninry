import 'package:flutter/material.dart';
import '../../../constant/colors.dart';

// 追加ボタン
class AddButton extends StatelessWidget {
  final Function() onPressed;
  const AddButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),  // まるくする
          padding: const EdgeInsets.all(5),
          // Button color
          backgroundColor: AppColors.iconLight,
          // Splash color
        ),
        child: const Icon(Icons.add, weight: 20, size: 55, color: AppColors.main));
  }
}
