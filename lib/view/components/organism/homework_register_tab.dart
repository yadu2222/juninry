import 'package:flutter/material.dart';
import 'package:juninry/view/components/atoms/teaching_tag.dart';
import '../atoms/listitem.dart';
import '../../../models/teaching_item_model.dart';

// 教材リスト表示
class HomeworkRegisterTab extends StatelessWidget {
  const HomeworkRegisterTab({super.key, required this.teachingItemData});

  final List<TeachingItem> teachingItemData;
  @override
  Widget build(BuildContext context) {
    return ListItem(
        widget: Wrap(
            spacing: 5, // 子ウィジェット間のスペース
            runSpacing: 7, // 行間のスペース
            alignment: WrapAlignment.start, // 子ウィジェットの配置
            children: teachingItemData.map((item) {
              return TeachingTag(
                itemData: item,
              );
            }).toList()));
  }
}
