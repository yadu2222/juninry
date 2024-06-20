import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../models/homework_model.dart';
import '../molecule/homework_card.dart';
import '../atoms/listItem_box.dart';

// 宿題のリスト
class HomeworkList extends StatelessWidget {
  const HomeworkList({super.key, required this.homeworkData});

  final List<Homework> homeworkData;
  @override
  Widget build(BuildContext context) {
    return ListItemBox<Homework>(
        itemDatas: homeworkData,
        listItem: (homework) => InkWell(
              onTap: () {
                // TODO:これユーザーによって挙動変わるべきでは？のきもち
                // 画面遷移
                context.push('/homework/submittion',
                    extra: {'homeworkId': homework.homeworkUuid});
              },
              child: HomeworkCard(homeworkData: homework),
            ));
  }
}
