import 'package:flutter/material.dart';

import '../../components/organism/student_List.dart';
import '../../components/atoms/appbar.dart';

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
      const Expanded(child: StudentList()),
    ]));
  }
}
