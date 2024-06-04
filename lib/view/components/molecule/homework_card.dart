import 'package:flutter/material.dart';
import '../../../constant/colors.dart';
import '../atoms/teaching_item.dart';

import '../atoms/listitem.dart';

class HomeworkCard extends StatelessWidget {
  HomeworkCard({
    super.key,
    required this.taskData,
  });
  final Map taskData;
  
  // 課題ID	task_uuid
  // 期限	task_limit
  // 教材ID	teaching_material_uuid
  // 開始ページ	start_page
  // ページ枚数	page_count
  // 投稿者ID	task_poster_uuid
  // 説明	task_note
  // 教材ID	teaching_material_uuid
  // 教材名	teaching_material_name
  // 教科ID	subject_id
  // 画像ID	image_uuid
  // クラスID	class_uuid
  // 提出済みかどうか	submit_flg

  final Icon checkIcon = const Icon(
    Icons.check,
    color: AppColors.buttonOk,
    size: 30,
  );
  final Icon cameraIcon = const Icon(
    Icons.camera_alt_sharp,
    color: AppColors.iconDark,
    size: 30,
  );

  @override
  Widget build(BuildContext context) {
    return ListItem(
        height: 60.0,
        widget: Row(
          children: [
            // 教材カード
            TeachingItem(itemData: taskData),
            const Spacer(), // 間隔を埋める
            // アイコン
            Container(
              alignment: Alignment.center,
              child: Center(child: int.parse(taskData['submit_flg']) == 1 ? checkIcon : cameraIcon),
            ),
          ],
        ));
  }
}
