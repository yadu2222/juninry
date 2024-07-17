import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:juninry/constant/fonts.dart';
import 'package:juninry/view/components/atoms/teaching_tag.dart';
import '../../../models/register_homework_model.dart';

import '../atoms/listitem.dart';
import '../../../constant/colors.dart';

class DraftCard extends StatelessWidget {
  const DraftCard({super.key, required this.onTap, required this.delete, required this.date, required this.widget});

  // 遷移先メソッド
  final void Function() onTap;
  // 削除メソッド
  final void Function() delete;
  // 日付
  final String date;
  // 表示するもの
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: ListItem(
        padding: const EdgeInsets.all(0),
        widget: Row(
          children: [
            IconButton(
              icon: const Icon(
                Icons.remove_circle,
                color: AppColors.buttonCheck,
              ),
              onPressed: delete,
            ),
            // 日付
            Text(
              date,
              style: Fonts.h4,
            ),
            const SizedBox(width: 10),
            Expanded(child: widget),
            const SizedBox(width: 10),

          ],
        ),
      ),
    );
  }
}
