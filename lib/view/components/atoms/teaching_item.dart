import 'package:flutter/material.dart';
import '../../../models/homework_model.dart';
import '../atoms/count_item.dart';
import '../atoms/teaching_tag.dart';

// 教材ラベルの表示
class TeachingItem extends StatelessWidget {
  TeachingItem({
    super.key,
    required this.itemData,
  });


  final Homework itemData;

  // TODO: 「枚数」対応
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: Row(children: [
      // 教材の表示
      TeachingTag(itemData: itemData.teachingItem),
      CountItem(itemData: itemData)
    ]));
  }
}
