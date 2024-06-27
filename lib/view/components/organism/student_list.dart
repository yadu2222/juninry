import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:juninry/constant/sample_data.dart';
import 'package:juninry/models/student_model.dart';

import '../../../router/router.dart';

import '../molecule/student_card.dart';
import '../atoms/listItem_box.dart';

class StudentList extends StatelessWidget {
  const StudentList({super.key, required this.studentData});

  final List<Student> studentData;


  // 教員かを判別するメソッド
  // ぶすでは？
  Future<bool> isTeacher() async{
    return (await getBranches() == BranchType.teacher.branch);
  }

  @override
  Widget build(BuildContext context) {
    return ListItemBox<Student>(
      itemDatas: studentData,
      listItem: (map) => InkWell(
          onTap: () async {
            // 画面遷移
            if (await isTeacher()) {
              context.push('/sample/teacher');
              return;
            }
            // context.push('/sample');
          },
          child: StudentCard(studentData: SampleData.studentData[0])),
    );
  }
}
