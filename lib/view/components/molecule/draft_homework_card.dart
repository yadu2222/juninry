import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:juninry/constant/fonts.dart';
import 'package:juninry/view/components/atoms/teaching_tag.dart';
import '../../components/molecule/divider.dart';

import '../../../models/homework_model.dart';
import '../atoms/listitem.dart';
import '../../../constant/colors.dart';

class DraftHomeworkCard extends StatelessWidget {
  const DraftHomeworkCard({super.key, required this.homeworkData});

  final List<Homework> homeworkData;

  @override
  Widget build(BuildContext context) {
    return ListItem(
      padding: const EdgeInsets.all(0),
      widget: Row(
        children: [
          IconButton(
            icon: const Icon(
              Icons.remove_circle,
              color: AppColors.buttonCheck,
            ),
            onPressed: () {
              // TODO:配列から削除
            },
          ),

          // 日付
          Text(
            DateFormat('MM.dd').format(homeworkData[0].homeworkLimit),
            style: Fonts.h4,
          ),

          const SizedBox(width: 10),

          Wrap(
            spacing: 5, // 子ウィジェット間のスペース
            alignment: WrapAlignment.start, // 子ウィジェットの配置
            children: homeworkData.asMap().entries.map((entry) {
              int index = entry.key;
              return index >= 2
                  ? index == 2
                      ? const Icon(
                          Icons.more_horiz,
                          color: AppColors.glay,
                        )
                      : const SizedBox.shrink()
                  : TeachingTag(itemData: entry.value.teachingItem);
            }).toList(),
          )
        ],
      ),
    );
  }
}
