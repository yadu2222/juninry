import 'package:flutter/material.dart';
import 'package:juninry/constant/colors.dart';

import '../../../constant/fonts.dart';
import '../atoms/listitem.dart';

// おしらせカード
// まだかいてない
class NoticeCard extends StatelessWidget {
  NoticeCard({
    super.key,
    required this.noticeData,
  });
  final Map noticeData;

  //未確認アイコン
  final Icon unknowIcon = const Icon(
    Icons.info,
    color: AppColors.buttonCheck,
    size: 30,
  );

  @override
  Widget build(BuildContext context) {
    return const ListItem(
      height: 50.0,
      // ここに箱の中に表示したいウィジェットを入れる
      widget: Column(
        children: [

        ],
        
        ),


    );
  }
}