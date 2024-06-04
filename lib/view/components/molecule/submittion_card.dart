import 'package:flutter/material.dart';
import '../../../constant/colors.dart';
import '../atoms/teaching_item.dart';

import '../atoms/listitem.dart';


// 提出ボタン
class SubmittionCard extends StatelessWidget {
  const SubmittionCard({Key? key}) : super(key: key);

  // カメラアイコン
  final Icon cameraIcon = const Icon(
    Icons.camera_alt_sharp,
    color: AppColors.iconDark,
    size: 30,
  );

  @override
  Widget build(BuildContext context) {
    return ListItem(
      height: 30.0,
      widget: Row(
        children: [
          Container(
            width: 100,
            height: 100,
            color: Colors.blue,
          ),
          Column(
            children: [
              Text(
                'タイトル',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
              Text(
                '説明',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
