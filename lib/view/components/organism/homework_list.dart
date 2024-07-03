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


  final bool isClass;  // クラス優先なのかどうか そうでなければ期日を優先する
  final List<dynamic> homeworkData;

  // 名前付きコンストラクタを用意することで表示を分岐
  // overloadみたいなものだよ
  const HomeworkList({super.key, required this.homeworkData, this.isClass = false});
  const HomeworkList.classes({super.key, required this.homeworkData,this.isClass = true});

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

          isClass ? DividerView(
            indent: 10,
            endIndent: 10,
            icon: Icons.menu_book_rounded,
            title: "${homeworkList['className']}",
            dividColor: AppColors.iconLight,
          ) :
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
                onTap: () async {
                  // 児童のときは遷移
                  if (await getBranches() == BranchType.junior.branch) {
                    context.push('/homework/submittion', extra: {'homeworkId': homework.homeworkUuid});
                  } else {
                    // TODO:児童じゃなかった場合かつ未提出の場合は催促の機能 現状仕様等未確定のため保留
                  }
                },
                child: HomeworkCard(
                  // カードウィジェット配置
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
    //             // TODO:これユーザーによって挙動変わるべきでは？のきもち
    //             // 画面遷移
    //             context.push('/homework/submittion',
    //                 extra: {'homeworkId': homework.homeworkUuid});
    //           },
    //           child: HomeworkCard(homeworkData: homework),
    //         ));
  }
}
