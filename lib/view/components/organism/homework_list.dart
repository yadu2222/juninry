import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../router/router.dart';
import 'package:juninry/constant/colors.dart';

import '../../../models/homework_model.dart';
import '../molecule/homework_card.dart';
import '../../components/molecule/divider.dart';
import 'package:intl/intl.dart'; // datetimeのフォーマット変換

// 宿題のリスト
class HomeworkList extends StatelessWidget {
  final bool isClass; // クラス優先なのかどうか そうでなければ期日を優先する
  final List<dynamic> homeworkData;
  final List<StatefulShellBranch> branchType;

  final void Function(String) cardPressed;

  // 名前付きコンストラクタを用意することで表示を分岐
  // overloadみたいなものだよ
  const HomeworkList.limit({super.key, required this.homeworkData, this.isClass = false, required this.cardPressed, required this.branchType});
  const HomeworkList.classes({super.key, required this.homeworkData, this.isClass = true, required this.cardPressed, required this.branchType});

  @override
  Widget build(BuildContext context) {
    // list化が複雑化したため独自に定義
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.92,
      // 空白に対応
      child: SingleChildScrollView(
          child: Column(
              children: homeworkData.asMap().entries.map((entry) {
        // リスト化
        final homeworkList = entry.value; // アイテム
        return Column(children: [
          // 期日またはクラス名で表示

          isClass
              ? DividerView(
                  indent: 10,
                  endIndent: 10,
                  icon: Icons.menu_book_rounded,
                  title: "${homeworkList['className']}",
                  dividColor: AppColors.iconLight,
                )
              : DividerView(
                  indent: 10,
                  endIndent: 10,
                  icon: Icons.calendar_month_outlined,
                  title: "${DateFormat('MM.dd').format(homeworkList['homeworkLimit'])}まで",
                  dividColor: AppColors.iconLight,
                ),
          ...homeworkList['homeworkData'].asMap().entries.map((entry) {
            // 期日ごとの宿題をリスト化
            final homework = entry.value; // アイテム
            // 宿題
            return InkWell(
                onTap: () async {
                  cardPressed(homeworkList['homeworkUUID']);
                },
                // カードウィジェット
                // userにあわせたものを表示
                child: branchType == BranchType.junior.branch
                    ? HomeworkCard.junior(
                        homeworkData: homework as Homework,
                      )
                    : branchType == BranchType.teacher.branch
                        ? HomeworkCard.teacher(
                            homeworkData: homework as Homework,
                          )
                        : HomeworkCard.patron(
                            homeworkData: homework as Homework,
                          ));
          }).toList() // キャスト
        ]);
      }).toList())), // キャスト
    );

    // もとのやつ
    // return ListItemBox<dynamic>(
    //     itemDatas: homeworkData,
    //     listItem: (homework) => InkWell(
    //           onTap: () {
    //             // 画面遷移
    //             context.push('/homework/submittion',
    //                 extra: {'homeworkId': homework.homeworkUuid});
    //           },
    //           child: HomeworkCard(homeworkData: homework),
    //         ));
  }
}
