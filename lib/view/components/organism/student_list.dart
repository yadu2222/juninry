import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:juninry/models/student_model.dart';

import '../molecule/student_card.dart';
import '../atoms/listItem_box.dart';

class StudentList extends StatelessWidget {
  const StudentList({super.key,required this.studentData});

  final List<Student> studentData;
  @override
  Widget build(BuildContext context) {
    return ListItemBox(
      itemDatas: studentData,
      listItem: (map) => InkWell(
          onTap: () {
            // 画面遷移
            context.push('/sample');
          },
          child: StudentCard(studentData: map)),
    );
  }
}
