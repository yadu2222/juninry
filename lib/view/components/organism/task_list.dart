import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../molecule/task_card.dart';
import '../atoms/listItem_box.dart';

class TaskList extends StatefulWidget {
  const TaskList({Key? key}) : super(key: key);

  @override
  _StudentListState createState() => _StudentListState();
}

class _StudentListState extends State<TaskList> {
  // sumple
  // ここで通信を行う
  final List<Map<String, String>> sumpleData = [
    {
      'task_uuid': 'aaaaa',
      'task_limit': '2022/12/12',
      'teaching_material_uuid': 'aaaaa',
      'start_page': '1',
      'page_count': '10',
      'task_poster_uuid': 'aaaaa',
      'task_note': 'aaaaa',
      'teaching_material_name': '漢字ドリル',
      'subject_id': '0',
      'image_uuid': 'aaaaa',
      'class_uuid': 'aaaaa',
      'submit_flg': '0',
    },
    {
      'task_uuid': 'aaaaa',
      'task_limit': '2022/12/12',
      'teaching_material_uuid': 'aaaaa',
      'start_page': '1',
      'page_count': '10',
      'task_poster_uuid': 'aaaaa',
      'task_note': 'aaaaa',
      'teaching_material_name': '計算ドリル',
      'subject_id': '1',
      'image_uuid': 'aaaaa',
      'class_uuid': 'aaaaa',
      'submit_flg': '1',
    }
  ];

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          // 画面遷移
          // context.push('/sample');
        },
        child: ListItemBox(
          itemDatas: sumpleData,
          listItem: (map) => TaskCard(taskData: map),
        ));
  }
}
