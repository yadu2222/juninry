import 'package:flutter/material.dart';
import '../../../constant/fonts.dart';
import '../../../constant/colors.dart';

import '../../../models/student_model.dart';
import '../atoms/listitem.dart';

// ここにあるのきもいね
enum JenderType { maile, female, others }
extension JenderTypeExt on JenderType {
  Icon get icon {
    switch (this) {
      case JenderType.maile:
        return const Icon(
          Icons.face_5,
          color: AppColors.subjectMath,
          size: 30,
        );
      case JenderType.female:
        return const Icon(
          Icons.face_5,
          color: AppColors.subjectJapanese,
          size: 30,
        );
      case JenderType.others:
        return const Icon(
          Icons.tag_faces_sharp,
          color: AppColors.main,
          size: 30,
        );
    }
  }
}

// 生徒カード
class StudentCard extends StatelessWidget {
  StudentCard({
    super.key,
    required this.studentData,
  });
  final Student studentData;

  @override
  Widget build(BuildContext context) {
    return ListItem(
        height: 60.0,
        widget: Row(
          children: [
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
                  // studentData.num.toString(),
                  'n',
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

            // 性別アイコン
            Container(
              alignment: Alignment.center,
              child: Center(
                  child:
                      // 性別を判別
                      studentData.gender == 1 ? JenderType.maile.icon : studentData.gender == 2 ? JenderType.female.icon : JenderType.others.icon),
            ),
          ],
        ));
  }
}
