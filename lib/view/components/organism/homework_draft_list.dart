import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../models/homework_model.dart';
import '../atoms/listItem_box.dart';
import '../molecule/draft_homework_card.dart';


// 宿題の下書きリスト
class HomeworkDraftList extends StatelessWidget {
  const HomeworkDraftList({super.key, required this.homeworkData});

  final List<List<Homework>> homeworkData;
  @override
  Widget build(BuildContext context) {
    return ListItemBox<List<Homework>>(
        itemDatas: homeworkData,
        listItem: (homework) => InkWell(
              onTap: () {
                // // 画面遷移
                context.push('/homework/register/',
                // 下書き一覧に選択した日付を渡す
                extra: {'selectDate': homework.first.homeworkLimit.toString()});
              },
              child: DraftHomeworkCard(homeworkData: homework),
            ));
  }
}