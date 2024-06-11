import 'package:flutter/material.dart';
import '../../../constant/colors.dart';
import '../../../constant/fonts.dart';

import '../atoms/listitem.dart';

// 提出カード
class SubmittionCard extends StatelessWidget {
  SubmittionCard({Key? key, required this.count}) : super(key: key);

  // カメラアイコン
  final Icon cameraIcon = const Icon(
    Icons.camera_alt_sharp,
    color: AppColors.iconDark,
    size: 30,
  );

  // 提出するページ
  final int count;
  @override
  Widget build(BuildContext context) {
    return ListItem(
        widget: Row(
      children: [
        // カメラアイコン
        cameraIcon,
        // 教材の表示
        Container(
          margin: const EdgeInsets.only(left: 10),
          child: Center(
            child: Text(
              '${count.toString()}p',
              style: Fonts.h4,
            ),
          ),
        ),
      ],
    ));
  }
}
