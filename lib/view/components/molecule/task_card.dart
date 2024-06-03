import 'package:flutter/material.dart';
import '../../../constant/fonts.dart';
import '../../../constant/colors.dart';

import '../atoms/listitem.dart';

class TaskCard extends StatelessWidget {
  TaskCard({
    super.key,
    required this.taskData,
  });
  final Map taskData;

  // 教科の色を配列で宣言
  final List<Color> colors = [
    AppColors.subjectJapanese,
    AppColors.subjectMath,
    AppColors.subjectScience,
    AppColors.subjectSocial,
    AppColors.subjectEnglish,
    AppColors.subjectOthers,
  ];

  // final List<String> subjects = [
  //   '国語',
  //   '数学',
  //   '理科',
  //   '社会',
  //   '英語',
  //   'その他',
  // ];

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
            // 教材の表示
            Container(
              width: 100,
              height: 25,
              decoration: BoxDecoration(
                color: colors[int.parse(taskData['subject_id'])],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  taskData['teaching_material_name'],
                  style: Fonts.pw,
                ),
              ),
            ),

            // ページ数の表示
            Container(
              margin: const EdgeInsets.only(left: 15),
              child: Center(
                child: Text(
                  "${taskData['start_page']} ~ ${(int.parse(taskData['start_page']) + int.parse(taskData['page_count']) - 1).toString()}ｐ",
                  style: Fonts.h4,
                ),
              ),
            ),

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
