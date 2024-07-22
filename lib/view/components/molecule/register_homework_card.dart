import 'package:flutter/material.dart';
import '../../../models/register_homework_model.dart';
import '../atoms/listItem.dart';
import '../atoms/teaching_tag.dart';
import '../atoms/count_form.dart';
import '../../../constant/colors.dart';

class RegisterHomeworkCard extends StatelessWidget {
  const RegisterHomeworkCard({
    super.key,
    required this.registerHomeworkData,
    required this.onTap,
    required this.index,
  });

  final RegisterHomework registerHomeworkData;
  final void Function(int index) onTap;
  final int index;

  @override
  Widget build(BuildContext context) {
    return ListItem(
        padding: const EdgeInsets.only(left: 5, right: 30),
        widget: Row(
          children: [
            IconButton(
              icon: const Icon(
                Icons.remove_circle,
                color: AppColors.buttonCheck,
              ),
              onPressed: () {
                // 配列から削除
                onTap(index);
              },
            ),
            // 教材の表示
            TeachingTag(itemData: registerHomeworkData.teachingItem),
            Expanded(
                child: CountForm(
              startController: registerHomeworkData.startPageController,
              countController: registerHomeworkData.pageCountController,
            ))
          ],
        ));
  }
}
