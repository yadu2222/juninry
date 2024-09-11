import 'package:flutter/material.dart';
import 'package:juninry/constant/colors.dart';
import 'package:juninry/constant/fonts.dart';
import 'package:juninry/models/user_model.dart';
import '../atoms/listitem.dart';

// 生徒カード
class UserCard extends StatelessWidget {
  const UserCard({
    super.key,
    required this.userData,
  });
  final User userData;

  @override
  Widget build(BuildContext context) {
    Widget faceIcon(IconData icon) {
      return Icon(
        icon,
        size: 30,
        color: AppColors.font,
      );
    }

    return ListItem(
        height: 60.0,
        widget: Row(children: [
          // アイコン
          Container(
            alignment: Alignment.center,
            child: Center(
              child: userData.userTypeId == 3 ? faceIcon(Icons.face_2) : faceIcon(Icons.face_5),
            ),
          ),

          const SizedBox(width: 10),
          Text(userData.userName, style: Fonts.p),
        ]));
  }
}
