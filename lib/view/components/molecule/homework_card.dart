import 'package:flutter/material.dart';
import '../../../constant/colors.dart';
import '../atoms/teaching_material.dart';

import '../../../models/homework_model.dart';
import '../atoms/listitem.dart';

// 課題カード
class HomeworkCard extends StatelessWidget {
  const HomeworkCard.patron({
    super.key,
    required this.homeworkData,
    this.isJunior = false,
    this.isTeacher = false,
  });

  const HomeworkCard.teacher({
    super.key,
    required this.homeworkData,
    this.isJunior = false,
    this.isTeacher = true,
  });
  const HomeworkCard.junior({super.key, required this.homeworkData, this.isJunior = true, this.isTeacher = false});
  final Homework homeworkData;
  final bool isJunior;
  final bool isTeacher;

  // TODO:user情報に合わせて判別すべきでは？ そのとおりだ

  final Icon checkIcon = const Icon(
    Icons.check,
    color: AppColors.buttonOk,
    size: 30,
  );
  final Icon cameraIcon = const Icon(
    Icons.camera_alt_sharp,
    color: AppColors.iconDark,
    size: 30,
  );

  @override
  Widget build(BuildContext context) {
    return ListItem(
        height: 60.0,
        widget: Row(
          children: [
            // 教材カード
            TeachingMaterial(itemData: homeworkData),
            const Spacer(), // 間隔を埋める
            // アイコン

            isTeacher
                ? const SizedBox.shrink()
                : Container(
                    alignment: Alignment.center,
                    // 課題の提出状態を判別している
                    child: Center(
                        child: homeworkData.submitFlg == 1
                            ? checkIcon
                            : isJunior
                                ? cameraIcon
                                : null),
                  ),
          ],
        ));
  }
}
