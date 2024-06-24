import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../models/register_homework_model.dart';
import '../atoms/listItem_box.dart';
import '../molecule/draft_homework_card.dart';


// 宿題の下書きリスト
class HomeworkDraftList extends StatelessWidget {
  const HomeworkDraftList({super.key, required this.homeworkData, required this.onTap});
  final List<List<RegisterHomework>> homeworkData;  // 下書きデータ
  final void Function(List<RegisterHomework>) onTap;  //　dbから削除
  @override
  Widget build(BuildContext context) {
    return ListItemBox<List<RegisterHomework>>(
        itemDatas: homeworkData,
        listItem: (homework) => InkWell(
              onTap: () {
                // // 画面遷移
                context.push('/homework/register/',
                // 下書き一覧に選択した日付を渡す
                // datetimeを渡すとrouterがエラーを吐くので、文字列に変換して渡す
                extra: {'selectDate': homework.first.homeworkLimit.toString()});
              },
              child: DraftHomeworkCard(homeworkData: homework,onTap: onTap),
            ));
  }
}