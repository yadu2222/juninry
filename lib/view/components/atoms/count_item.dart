import 'package:flutter/material.dart';
import '../../../constant/fonts.dart';

import '../../../models/homework_model.dart';

// ページ数カウント
class CountItem extends StatelessWidget {
  const CountItem({
    Key? key,
    required this.itemData,
  }) : super(key: key);

  final Homework itemData;

  @override
  Widget build(BuildContext context) {
    return // ページ数の表示
        Container(
      margin: const EdgeInsets.only(left: 15),
      child: Center(
        child: Text(
          "${itemData.startPage.toString()} ~ ${(itemData.startPage + itemData.pageCount - 1).toString()}ｐ",
          style: Fonts.h4,
        ),
      ),
    );
  }
}
