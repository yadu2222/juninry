import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
import 'package:juninry/models/student_model.dart';
import 'package:juninry/constant/colors.dart';

import '../../../router/router.dart';
import '../../components/molecule/divider.dart';
import '../molecule/student_card.dart';
import '../atoms/listItem_box.dart';

class StudentList extends StatelessWidget {
  final List<dynamic> studentData;
  final void Function(int)? isShow;
  final List<bool>? isShowList; // そのクラスを表示するか
  final bool classes; // 複数クラス表示か否か

  const StudentList({super.key, required this.studentData, this.isShow,this.isShowList, this.classes = false});
  const StudentList.classes({super.key, required this.studentData, required this.isShow,required this.isShowList,  this.classes = true});

  @override
  Widget build(BuildContext context) {
    void isTeacher() async {
      // 教員であれば
      if (await isBranch(BranchType.teacher)) {
        // context.push('/homework/submittion', extra: {'homeworkId': student.homeworkUuid});
        // なんか遷移する
        // 遷移先がまだ
      }
    }

    // list化が複雑化したため独自に定義
    return classes
        ? SizedBox(
            width: MediaQuery.of(context).size.width * 0.92,
            // 空白に対応
            child: SingleChildScrollView(
                child: Column(
                    children: studentData.asMap().entries.map((entry) {
              // リスト化
              final key = entry.key; // インデックス
              final studentList = entry.value; // アイテム
              return Column(children: [
                // クラス名を表示
                DividerView(
                    indent: 10,
                    endIndent: 10,
                    icon: Icons.menu_book_rounded,
                    title: "${studentList['className']}",
                    dividColor: AppColors.iconLight,
                    endIcon: InkWell(
                      child: const Icon(Icons.expand_more, color: AppColors.iconLight, size: 30),
                      onTap: () {
                        isShow!(key);
                      },
                    )),
                ...studentList['students'].asMap().entries.map((entry) {
                  // 児童カード
                  final student = entry.value as Student; // アイテム
                  return 
                      isShowList![key] ?
                  InkWell(
                      onTap: () async {
                        isTeacher();
                      },
                      child: StudentCard(studentData: student))  : const SizedBox.shrink();
                }).toList(),
              ]);
            }).toList())))
        : ListItemBox<dynamic>(
            itemDatas: studentData,
            listItem: (index) => InkWell(
                onTap: () async {
                  isTeacher();
                },
                child: StudentCard(studentData: studentData[index] as Student)),
          );
  }
}
