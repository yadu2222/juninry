import 'package:flutter/material.dart';
import '../atoms/listItem_box.dart';
import '../molecule/due_homework_card.dart';

class DueHomeworkList extends StatelessWidget {
  const DueHomeworkList({super.key, required this.homeworkData});
  final List homeworkData;
  @override
  Widget build(BuildContext context) {
    return ListItemBox(itemDatas: homeworkData, listItem: (homework) => DueHomeworkCard(homeworkData: homework['homeworkData'], dueDate: homework['dueDate']));
  }
}
