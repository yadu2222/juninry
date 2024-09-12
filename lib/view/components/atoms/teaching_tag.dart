import 'package:flutter/material.dart';
import '../../../models/teaching_item_model.dart';
import '../../../constant/fonts.dart';
import '../../../constant/colors.dart';

// 教材ラベル
class TeachingTag extends StatelessWidget {
  TeachingTag({
    super.key,
    required this.itemData,
  });

  // 教科の色を配列で宣言
  final List<Color> colors = [
    AppColors.subjectJapanese,
    AppColors.subjectMath,
    AppColors.subjectScience,
    AppColors.subjectSocial,
    AppColors.subjectEnglish,
    AppColors.subjectOthers,
  ];

  final TeachingItem itemData;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: Wrap(children: [
      // 教材の表示
      Container(
        // TODO 可変
        width: 100,
        height: 25,
        decoration: BoxDecoration(
          color: colors[itemData.subjectId - 1],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            itemData.teachingMaterialName,
            style: Fonts.pw,
          ),
        ),
      ),
    ]));
  }
}
