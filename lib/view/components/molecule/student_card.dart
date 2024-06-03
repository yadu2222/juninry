import 'package:flutter/material.dart';
import '../../../constant/fonts.dart';
import '../../../constant/colors.dart';

import '../atoms/listitem.dart';

class StudentCard extends StatelessWidget {
  StudentCard({
    super.key,
    required this.studentData,
  });
  final Map studentData;

  // 男性アイコン
  final Icon maleIcon = const Icon(
    Icons.face_5,
    color: AppColors.subjectMath,
    size: 30,
  );

  // 女性アイコン
  final Icon femaleIcon = const Icon(
    Icons.face_5,
    color: AppColors.subjectJapanese,
    size: 30,
  );

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
                  studentData['num'],
                  style: Fonts.h3,
                ),
              ),
            ),
            // 名前
            Container(
              height: 30,
              margin: const EdgeInsets.only(left: 15),
              child: Center(
                child: Text(
                  studentData['name'],
                  style: Fonts.h3,
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
                      // TODO:条件文分かり次第変更
                      studentData['gender'] == '男' ? maleIcon : femaleIcon),
            ),
          ],
        ));
  }
}
