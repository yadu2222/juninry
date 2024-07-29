import 'package:flutter/material.dart';
import '../../../constant/fonts.dart';
import '../../../constant/colors.dart';
import '../../../models/student_model.dart';

class StudentView {
  static List<Widget> getChildren(Student studentData) {
    return [
      // 出席番号
      Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: AppColors.glay,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
          child: Text(
            studentData.num.toString(),
            style: Fonts.p,
          ),
        ),
      ),
      // 名前
      Container(
        height: 30,
        margin: const EdgeInsets.only(left: 15),
        child: Center(
          child: Text(
            studentData.name,
            style: Fonts.h4,
          ),
        ),
      ),
      const Spacer(), // 間隔を埋める
    ];
  }
}
