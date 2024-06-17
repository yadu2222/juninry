import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:juninry/constant/colors.dart';

import '../../../models/homework_model.dart';
import '../../components/molecule/next_day_task.dart';
import '../../components/atoms/teaching_item.dart';

// 明日の宿題 タスクタブ
class HomeworkTab extends StatelessWidget {
  const HomeworkTab({
    super.key,
    required this.homeworkData,
  });

  // サンプルデータ
  final List<Homework> homeworkData;
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          // 画面遷移
          context.push('/homework/nextday');
        },
        child: Stack(children: [
          NextDayTask(
              margin: const EdgeInsets.only(bottom: 20, top: 10),
              widget: SizedBox(
                  // height: 35 * homeworkData.length + 0.0, // 35px * データ数
                  // padding: const EdgeInsets.only(bottom: 10),
                  child: Column(
                      // 繰り返し表示
                      // スクロールはさせない！！！！！！！！！！
                      children: List.generate(homeworkData.length, (index) {
                return Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: TeachingItem(itemData: homeworkData[index]),
                );
              })))),
          const Positioned(bottom: 35, right: 30, child: Icon(Icons.launch, size: 25, color: AppColors.iconDark))
        ]));
  }
}
