import 'package:flutter/material.dart';
import '../../../constant/fonts.dart';

import './homework_tab.dart';

class HomeWorkTabs extends StatelessWidget {
  const HomeWorkTabs({super.key, required this.homeworkData});

  final List<Map>? homeworkData;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 310, // TODO: 定数になっているため、調整が必要 可変にしたいよ〜〜！
        child: homeworkData != null
            ? ListView.builder(
                itemCount: homeworkData!.length,
                scrollDirection: Axis.horizontal, // 横スクロール
                itemBuilder: (context, index) {
                  return Container(
                      margin: const EdgeInsets.only(right: 20, left: 20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(homeworkData![index]['juniorName'], style: Fonts.h4w), // 児童の名前
                          HomeworkTab(homeworkData: homeworkData![index]['homeworkData']) // 進捗・課題内容の表示
                        ],
                      ));
                },
              )
            : const SizedBox.shrink());
  }
}
