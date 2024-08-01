import 'package:flutter/material.dart';
import 'package:juninry/models/student_model.dart';
import 'package:juninry/view/components/atoms/listItem_box.dart';
import 'package:juninry/view/components/molecule/student_card.dart';

class StudentReadStatusList extends StatelessWidget {
  final List<Student> studentData;
  const StudentReadStatusList({super.key, required this.studentData});

  @override
  Widget build(BuildContext context) {
    return ListItemBox(
        itemDatas: studentData,
        listItem: (student) => StudentCard(studentData: student, readStatusList: true));
  }
}
