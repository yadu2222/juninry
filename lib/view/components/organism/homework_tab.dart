import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:juninry/constant/colors.dart';

import '../../components/molecule/next_day_task.dart';
import '../../components/atoms/teaching_item.dart';

// 明日の宿題 タスクタブ
class TaskTab extends StatelessWidget {
  TaskTab({
    Key? key,
  }) : super(key: key);

  // ソートはサーバー側でやってもらえるとうれしいなあという希望
  // 提出期限ソート
  // クラスでソート
  // 提出状況でソート // こっちはクライアントでも簡単にできる軽い処理なのでなくてもいいです
  // 以上３つがあるといいかもです
  final List<Map> sample = [
    {
      'task_limit':'',
      'taskData': {
        'task_uuid': 'aaaaa', // 課題ID
        'start_page': '1', // 開始ページ
        'page_count': '10', // ページ数
        'task_note': 'aaaaa', // 課題の説明
        'teaching_material_name': '漢字ドリル', // 教材名
        'subject_id': '0', // 教科ID
        'image_uuid': 'aaaaa', // 画像ID どういう扱いになるのかな
        'class_name': '3-2 ふたば学級', // クラス名
        'submit_flg': '0', // 提出済みかどうか
      }
    }
  ];

  final List<Map> taskData = [
    {
      'task_uuid': 'aaaaa',
      'task_limit': '2022/12/12',
      'teaching_material_uuid': 'aaaaa',
      'start_page': '1',
      'page_count': '10',
      'task_poster_uuid': 'aaaaa',
      'task_note': 'aaaaa',
      'teaching_material_name': '漢字ドリル',
      'subject_id': '0',
      'image_uuid': 'aaaaa',
      'class_uuid': 'aaaaa',
      'submit_flg': '0',
    },
    {
      'task_uuid': 'aaaaa',
      'task_limit': '2022/12/12',
      'teaching_material_uuid': 'aaaaa',
      'start_page': '1',
      'page_count': '10',
      'task_poster_uuid': 'aaaaa',
      'task_note': 'aaaaa',
      'teaching_material_name': '計算ドリル',
      'subject_id': '1',
      'image_uuid': 'aaaaa',
      'class_uuid': 'aaaaa',
      'submit_flg': '1',
    },
    {
      'task_uuid': 'aaaaa',
      'task_limit': '2022/12/12',
      'teaching_material_uuid': 'aaaaa',
      'start_page': '1',
      'page_count': '3',
      'task_poster_uuid': 'aaaaa',
      'task_note': 'aaaaa',
      'teaching_material_name': '理科ワーク',
      'subject_id': '2',
      'image_uuid': 'aaaaa',
      'class_uuid': 'aaaaa',
      'submit_flg': '1',
    }
  ];

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
                      children: List.generate(taskData.length, (index) {
                    return Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: TeachingItem(itemData: taskData[index]),
                    );
                  })))),
          Positioned(bottom: 30, right: 15, child: Icon(Icons.launch, size: 25, color: AppColors.iconDark))
        ]));
  }
}
