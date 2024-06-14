import 'package:flutter/material.dart';
import '../../../constant/fonts.dart';

import './homework_tab.dart';

class HomeWorkTabs extends StatelessWidget {
  const HomeWorkTabs({super.key, required this.homeworkData});

  final List<Map>? homeworkData;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 310,    // TODO: 定数になっているため、調整が必要
        child: homeworkData != null
            ? ListView.builder(
                itemCount: homeworkData!.length,
                scrollDirection: Axis.horizontal, // 横スクロール
                itemBuilder: (context, index) {
                  return Container(
                      padding: const EdgeInsets.only(top: 15),
                      child: Column(
                        children: [
                          Text(homeworkData![index]['juniorName'], style: Fonts.h4w), // 児童の名前
                          HomeworkTab(
                              homeworkData: homeworkData![index]['homeworkData']) // 進捗・課題内容の表示
                        ],
                      ));
                },
              )
            : const SizedBox.shrink());
  }
}
