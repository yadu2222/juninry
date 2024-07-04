import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:juninry/constant/sample_data.dart';
import 'package:juninry/models/student_model.dart';
import 'package:juninry/constant/colors.dart';

import '../../../router/router.dart';
import '../../components/molecule/divider.dart';
import '../molecule/student_card.dart';
import '../atoms/listItem_box.dart';

class StudentList extends StatelessWidget {
  const StudentList({super.key, required this.studentData});

  final List<dynamic> studentData;

  // 教員かを判別するメソッド
  // ぶすでは？
  Future<bool> isTeacher() async {
    return (await getBranches() == BranchType.teacher.branch);
  }

  @override
  Widget build(BuildContext context) {
    // list化が複雑化したため独自に定義
    return SizedBox(
        width: MediaQuery.of(context).size.width * 0.92,
        // 空白に対応
        child: SingleChildScrollView(
            child: Column(
                children: studentData.asMap().entries.map((entry) {
          // リスト化
          final studentList = entry.value; // アイテム
          return Column(children: [
            // クラス名を表示
            DividerView(
              indent: 10,
              endIndent: 10,
              icon: Icons.menu_book_rounded,
              title: "${studentList['className']}",
              dividColor: AppColors.iconLight,
              
            ),
            ...studentList['students'].asMap().entries.map((entry) {
              // 児童カード
              final student = entry.value; // アイテム
              return InkWell(
                  onTap: () async {
                    // TODO:先生なら生徒のマイページに遷移
                    if (await getBranches() == BranchType.teacher.branch) {
                      // context.push('/homework/submittion', extra: {'homeworkId': student.homeworkUuid});
                      // なんか遷移する
                      // 遷移先がまだ
                    }
                  },
                  child: StudentCard(studentData: student));
            }).toList(),
          ]);
        }).toList())));

    // ListItemBox<Student>(
    //   itemDatas: studentData,
    //   listItem: (map) => InkWell(
    //       onTap: () async {
    //         // 画面遷移
    //         if (await isTeacher()) {
    //           context.push('/sample/teacher');
    //           return;
    //         }
    //         // context.push('/sample');
    //       },
    //       child: StudentCard(studentData: SampleData.studentData[0])),
    // );
  }
}
