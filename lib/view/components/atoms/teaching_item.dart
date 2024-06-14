import 'package:flutter/material.dart';
import '../../../models/homework_model.dart';
import '../../../constant/fonts.dart';
import '../../../constant/colors.dart';
import '../atoms/count_item.dart';

// 教材ラベルの表示
class TeachingItem extends StatelessWidget {
  TeachingItem({
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

  final Homework itemData;

  // TODO: 「枚数」対応
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: Row(children: [
      // 教材の表示
      Container(
        width: 100,
        height: 25,
        decoration: BoxDecoration(
          color: colors[itemData.subjectId],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            itemData.teachingMaterialName,
            style: Fonts.pw,
          ),
        ),
      ),
      CountItem(itemData: itemData)
    ]));
  }
}
