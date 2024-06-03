import 'package:flutter/material.dart';
import '../../../constant/fonts.dart';
import '../../../constant/colors.dart';

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

  final Map itemData;

  // TODO: 「枚数」対応
  @override
  Widget build(BuildContext context) {
    return Container(
        
        child: Row(children: [
          // 教材の表示
          Container(
            width: 100,
            height: 25,
            decoration: BoxDecoration(
              color: colors[int.parse(itemData['subject_id'])],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                itemData['teaching_material_name'],
                style: Fonts.pw,
              ),
            ),
          ),

          // ページ数の表示
          Container(
            margin: const EdgeInsets.only(left: 15),
            child: Center(
              child: Text(
                "${itemData['start_page']} ~ ${(int.parse(itemData['start_page']) + int.parse(itemData['page_count']) - 1).toString()}ｐ",
                style: Fonts.h4,
              ),
            ),
          ),
        ]));
  }
}
