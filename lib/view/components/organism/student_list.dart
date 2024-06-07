import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../molecule/student_card.dart';
import '../atoms/listItem_box.dart';

// 生徒リスト
class StudentList extends StatefulWidget {
  const StudentList({super.key});

  @override
  _StudentListState createState() => _StudentListState();
}

class _StudentListState extends State<StudentList> {
  // sumple
  // ここで通信を行う
  final List<Map<String, String>> sumpleData = [
    {
      'name': '山田太郎',
      'num': '34',
      'gender': '男',
    },
    {
      'name': '山田花子',
      'num': '35',
      'gender': '女',
    },
    {
      'name': '山田太郎',
      'num': '34',
      'gender': '男',
    },
    {
      'name': '山田花子',
      'num': '35',
      'gender': '女',
    },
    {
      'name': '山田太郎',
      'num': '34',
      'gender': '男',
    },
    {
      'name': '山田花子',
      'num': '35',
      'gender': '女',
    },
    {
      'name': '山田太郎',
      'num': '34',
      'gender': '男',
    },
    {
      'name': '山田花子',
      'num': '35',
      'gender': '女',
    },
    {
      'name': '山田太郎',
      'num': '34',
      'gender': '男',
    },
    {
      'name': '山田花子',
      'num': '35',
      'gender': '女',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListItemBox(
      itemDatas: sumpleData,
      listItem: (map) => InkWell(
          onTap: () {
            // 画面遷移
            context.push('/sample');
          },
          child: StudentCard(studentData: map)),
    );
  }
}
