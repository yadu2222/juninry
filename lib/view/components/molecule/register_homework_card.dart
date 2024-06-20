import 'package:flutter/material.dart';
import '../../../models/register_homework_model.dart';
import '../atoms/listItem.dart';
import '../atoms/teaching_tag.dart';
import '../atoms/count_form.dart';
import '../../../constant/colors.dart';

class RegisterHomeworkCard extends StatelessWidget {
  const RegisterHomeworkCard({super.key, required this.registerHomeworkData});

  final RegisterHomework registerHomeworkData;
  @override
  Widget build(BuildContext context) {
    return ListItem(
        widget: Row(
      children: [
        IconButton(
          icon: Icon(
            Icons.remove_circle,
            color: AppColors.buttonCheck,
          ),
          onPressed: () {},
        ),
        // 教材の表示
        TeachingTag(itemData: registerHomeworkData.teachingItem),
        Expanded(child: CountForm())
      ],
    ));
  }
}
