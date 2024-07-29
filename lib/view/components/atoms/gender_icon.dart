import 'package:flutter/material.dart';
import '../../../constant/colors.dart';

enum GenderType {
  male('Male', Icons.face_5, AppColors.subjectMath),
  female('Female', Icons.face_5, AppColors.subjectJapanese),
  others('Others', Icons.tag_faces_sharp, AppColors.main);

  const GenderType(this.displayName, this.iconData, this.color);

  final String displayName;
  final IconData iconData;
  final Color color;

  Icon getIcon({double size = 30.0}) {
    return Icon(
      iconData,
      color: color,
      size: size,
    );
  }
}
