import 'package:flutter/material.dart';
import '../../../constant/fonts.dart';

import './homework_tab.dart';

class HomeWorkTabs extends StatelessWidget {
  const HomeWorkTabs({super.key, required this.homeworkData});

  final List<Map> homeworkData;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 315,      // TODO:定数になってしまっているため後で修正
        padding: const EdgeInsets.only(top: 15, bottom: 15),
        child: ListView.builder(
          itemCount: homeworkData.length,
          scrollDirection: Axis.horizontal, // 横スクロール
          itemBuilder: (context, index) {
            return Container(
                margin: const EdgeInsets.only(left: 15, right: 15),
                child: Column(
                  children: [
                    Text(homeworkData[index]['juniorName'], style: Fonts.h4w), // 児童の名前
                    HomeworkTab(homeworkData: homeworkData[index]['homeworkData']) // 宿題タブ
                  ],
                ));
          },
        ));
  }
}
