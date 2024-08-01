import 'package:flutter/material.dart';
import 'package:juninry/constant/colors.dart';
import '../atoms/gender_icon.dart';
import '../atoms/student_view.dart';
import '../../../models/student_model.dart';
import '../atoms/listitem.dart';

// 生徒カード
class StudentCard extends StatelessWidget {
  StudentCard({
    super.key,
    required this.studentData,
    this.readStatusList = false,
  });
  final Student studentData;
  final bool readStatusList;

  @override
  Widget build(BuildContext context) {
    return ListItem(
        height: 60.0,
        widget: Row(children: [
          ...StudentView.getChildren(studentData),
          const Spacer(), // 間隔を埋める
          // 性別アイコン
          Container(
            alignment: Alignment.center,
            child: Center(
                child: readStatusList
                    ? Icon(
                        color: AppColors.buttonOk,
                        size: 30,
                        studentData.readStatus == 1 ? Icons.check : null)
                    :
                    // 性別を判別
                    studentData.gender == 1
                        ? GenderType.male.getIcon()
                        : studentData.gender == 2
                            ? GenderType.female.getIcon()
                            : GenderType.others.getIcon()),
          ),
        ]));
  }
}
