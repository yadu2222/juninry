import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:juninry/constant/colors.dart';

import '../../../models/homework_model.dart';
import '../molecule/homework_card.dart';
import '../../components/molecule/divider.dart';
import 'package:intl/intl.dart'; // datetimeのフォーマット変換
// import '../atoms/listItem_box.dart';

// 宿題のリスト
class HomeworkList extends StatelessWidget {
  const HomeworkList({super.key, required this.homeworkData});

  final List<dynamic> homeworkData;
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
          // 期日の表示
          DividerView(
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
                onTap: () {
                  // 画面遷移
                  // ユーザーに合わせて挙動を変更
                  context.push('/homework/submittion', extra: {'homeworkId': homework.homeworkUuid});
                },
                child: HomeworkCard(
                  // カードウィジェット配置
                  homeworkData: homework as Homework,
                ));
          }).toList() // キャスト
        ]);
      }).toList())), // キャスト
    );

    // return ListItemBox<dynamic>(
    //     itemDatas: homeworkData,
    //     listItem: (homework) => InkWell(
    //           onTap: () {
    //             // TODO:これユーザーによって挙動変わるべきでは？のきもち
    //             // 画面遷移
    //             context.push('/homework/submittion',
    //                 extra: {'homeworkId': homework.homeworkUuid});
    //           },
    //           child: HomeworkCard(homeworkData: homework),
    //         ));
  }
}
