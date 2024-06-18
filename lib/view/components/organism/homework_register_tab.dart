import 'package:flutter/material.dart';
import 'package:juninry/view/components/atoms/teaching_tag.dart';
import '../atoms/listitem.dart';
import '../../../models/teaching_item_model.dart';

// 教材リスト表示
class HomeworkRegisterTab extends StatelessWidget {
  const HomeworkRegisterTab({super.key, required this.teachingItemData, required this.onTap});

  final List<TeachingItem> teachingItemData;
  final void Function(int) onTap;
  @override
  Widget build(BuildContext context) {
    return ListItem(
        widget: Wrap(
            spacing: 5, // 子ウィジェット間のスペース
            runSpacing: 7, // 行間のスペース
            alignment: WrapAlignment.start, // 子ウィジェットの配置
            children: teachingItemData.asMap().entries.map((entry) {
              final index = entry.key; // インデックス
              final item = entry.value; // アイテム
              return InkWell(
                  onTap: () {
                    // 画面遷移
                    onTap(index);
                  },
                  child: TeachingTag(
                    itemData: item,
                  ));
            }).toList()));
  }
}
