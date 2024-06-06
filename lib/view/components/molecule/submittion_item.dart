import 'package:flutter/material.dart';
import '../../../constant/colors.dart';
import '../../../constant/fonts.dart';

import '../atoms/listitem.dart';

// カメラを使用するためのライブラリ
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

// 提出ボタン
class SubmittionCard extends StatelessWidget {
  SubmittionCard({Key? key, required this.count}) : super(key: key);

  // カメラアイコン
  final Icon cameraIcon = const Icon(
    Icons.camera_alt_sharp,
    color: AppColors.iconDark,
    size: 30,
  );

  // 提出するページ
  final String count;
  @override
  Widget build(BuildContext context) {
    return InkWell(
        // カメラを起動する
        onTap: () {},
        child: ListItem(
            widget: Row(
          children: [
            // カメラアイコン
            cameraIcon,
            // 教材の表示
            Container(
              margin: const EdgeInsets.only(left: 10),
              child: Center(
                child: Text(
                  '${count}p',
                  style: Fonts.h4,
                ),
              ),
            ),
          ],
        )));
  }
}
