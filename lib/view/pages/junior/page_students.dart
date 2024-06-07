import 'package:flutter/material.dart';

import '../../components/template/basic_template.dart';
import '../../components/organism/student_List.dart';
import '../../../constant/sample_data.dart'; // sampleData

class PageStudentsJunior extends StatelessWidget {
  const PageStudentsJunior({super.key});

  final String title = '生徒一覧';
  @override
  Widget build(BuildContext context) {
    return BasicTemplate(
      title: title, 
      popIcon: true,
      children: [
      Expanded(child: StudentList(studentData: SampleData.studentData)),
    ]);
  }
}
