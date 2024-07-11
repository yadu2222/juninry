import 'package:flutter/material.dart';
// view
import '../atoms/listitem.dart';
import '../atoms/basic_button.dart';
// model
import '../../../models/class_model.dart';
// constant
import 'package:juninry/constant/fonts.dart';

class JoinClassCard extends StatelessWidget {
  const JoinClassCard({
    super.key,
    required this.classData,
    required this.onTap,
  });

  final Class classData;
  final void Function(Class) onTap;

  @override
  Widget build(BuildContext context) {
    return ListItem(
        widget: IntrinsicHeight(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween, // 両端に寄せる
                crossAxisAlignment: CrossAxisAlignment.center, // 子要素を縦方向に中央揃え
                children: [
          // icon
          Row(children: [
            // クラスの名前
            Text(
              classData.className,
              style: Fonts.h4,
            ),
          ]),
          // 招待コード再発行ボタン
          // TODO:先生にだけ表示
          BasicButton(
              iconSize: 20,
              margin: const EdgeInsets.only(),
              width: 0.3,
              icon: Icons.key,
              text: '招待',
              isColor: true,
              onPressed: () {
                onTap(classData);
              }),
        ])));
  }
}
