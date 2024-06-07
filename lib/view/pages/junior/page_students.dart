import 'package:flutter/material.dart';

import '../../components/organism/student_List.dart';
import '../../components/atoms/appbar.dart';
import '../../../constant/sample_data.dart'; // sampleData

class PageStudentsJunior extends StatelessWidget {
  const PageStudentsJunior({Key? key}) : super(key: key);

  final String title = '生徒一覧';
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(children: [
      AppBarView(
        titleText: title,
        popIconButton: true,
      ),
      Expanded(child: StudentList(studentData: SampleData.studentData)),
    ]));
  }
}
