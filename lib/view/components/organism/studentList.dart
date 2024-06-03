import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../components/molecule/studentCard.dart';
import '../atoms/listItemBox.dart';

class StudentList extends StatefulWidget {
  const StudentList({Key? key}) : super(key: key);

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
    return InkWell(
        onTap: () {
          // 画面遷移
          context.push('/sample');
        },
        child: ListItemBox(
          itemDatas: sumpleData,
          listItem: (map) => StudentCard(studentData: map),
        ));
  }
}
