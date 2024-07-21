import 'package:flutter/material.dart';
import '../../components/molecule/divider.dart';

import '../../../models/homework_model.dart';
import '../molecule/homework_card.dart';

class DueHomeworkCard extends StatelessWidget {
  const DueHomeworkCard({super.key, required this.homeworkData, required this.dueDate});

  final DateTime dueDate; // 期限
  final List<Homework> homeworkData; // 課題データ

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(bottom: 10),
        child: Column(children: [
          // 期限
          DividerView(
            indent: 10,
            endIndent: 10,
            title: '${dueDate.month}/${dueDate.day} まで',
            icon: Icons.calendar_today_rounded,
          ),
          // 課題データのリスト
          Column(
              children: List.generate(homeworkData.length, (index) {
            return InkWell(onTap: () {

              // TODO:遷移
            }, child: HomeworkCard(homeworkData: homeworkData[index]));
          }))
        ]));
  }
}
