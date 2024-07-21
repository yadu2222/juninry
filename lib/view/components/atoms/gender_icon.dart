import 'package:flutter/material.dart';
import '../../../constant/colors.dart';

enum GenderType { maile, female, others }
extension JenderTypeExt on GenderType {
  Icon get icon {
    switch (this) {
      case GenderType.maile:
        return const Icon(
          Icons.face_5,
          color: AppColors.subjectMath,
          size: 30,
        );
      case GenderType.female:
        return const Icon(
          Icons.face_5,
          color: AppColors.subjectJapanese,
          size: 30,
        );
      case GenderType.others:
        return const Icon(
          Icons.tag_faces_sharp,
          color: AppColors.main,
          size: 30,
        );
    }
  }
}