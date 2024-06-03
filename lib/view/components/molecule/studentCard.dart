import 'package:flutter/material.dart';
import '../../../constant/fonts.dart';
import '../../../constant/colors.dart';

import '../atoms/listitem.dart';

class StudentCard extends StatelessWidget {
  const StudentCard({
    super.key,
    required this.studentData,
  });
  final Map studentData;

  @override
  Widget build(BuildContext context) {
    return ListItem(
        height: 60.0,
        widget: Row(
          children: [
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

            Container(
              alignment: Alignment.center,
              child: Center(
                  child: Icon(
                studentData['gender'] == '男' ? Icons.face_5 : Icons.face_3_outlined,
                color: studentData['gender'] == '男' ? AppColors.subjectMath : AppColors.subjectJapanese,
                size: 30,
              )),
            ),
          ],
        ));
  }
}
