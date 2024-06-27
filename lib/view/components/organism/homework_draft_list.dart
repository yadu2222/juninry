import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';

import '../../../models/register_homework_model.dart';
import '../atoms/listItem_box.dart';
import '../molecule/draft_homework_card.dart';


// 宿題の下書きリスト
class HomeworkDraftList extends StatelessWidget {
  const HomeworkDraftList({super.key, required this.homeworkData, required this.delete, required this.onTap});
  final List<List<RegisterHomework>> homeworkData;  // 下書きデータ
  final void Function(List<RegisterHomework>) delete;  //　dbから削除
  final void Function(List<RegisterHomework>) onTap;  // 遷移と再起
  @override
  Widget build(BuildContext context) {
    return ListItemBox<List<RegisterHomework>>(
        itemDatas: homeworkData,
        listItem: (homework) => InkWell(
              onTap: () {
                onTap(homework);
              },
              child: DraftHomeworkCard(homeworkData: homework,onTap: delete),
            ));
  }
}