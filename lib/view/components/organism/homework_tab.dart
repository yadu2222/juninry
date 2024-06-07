import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:juninry/constant/colors.dart';

import '../../../models/homework_model.dart';
import '../../components/molecule/next_day_task.dart';
import '../../components/atoms/teaching_item.dart';

// 明日の宿題 タスクタブ
class TaskTab extends StatelessWidget {
  TaskTab({
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
              widget: Container(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Column(
                      // 繰り返し表示
                      // スクロールはさせない！！！！！！！！！！
                      children: List.generate(homeworkData.length, (index) {
                    return Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: TeachingItem(itemData: homeworkData[index]),
                    );
                  })))),
          Positioned(bottom: 30, right: 15, child: Icon(Icons.launch, size: 25, color: AppColors.iconDark))
        ]));
  }
}
