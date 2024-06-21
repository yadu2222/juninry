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
                // context.push('/homework/drafts/edit',
                //     extra: {'homeworkId': homework.homeworkUuid});
                // TODO:この値をもって入力画面に遷移
              },
              child: DraftHomeworkCard(homeworkData: homework),
            ));
  }
}