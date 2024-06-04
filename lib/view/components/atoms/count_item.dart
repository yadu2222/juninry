import 'package:flutter/material.dart';
import '../../../constant/fonts.dart';
import '../../../constant/colors.dart';


// ページ数カウント
class CountItem extends StatelessWidget {
  const CountItem({Key? key,
      required this.itemData,
  }) : super(key: key);

  final Map itemData;

  @override
  Widget build(BuildContext context) {
    return // ページ数の表示
        Container(
      margin: const EdgeInsets.only(left: 15),
      child: Center(
        child: Text(
          "${itemData['start_page']} ~ ${(int.parse(itemData['start_page']) + int.parse(itemData['page_count']) - 1).toString()}ｐ",
          style: Fonts.h4,
        ),
      ),
    );
  }
}
