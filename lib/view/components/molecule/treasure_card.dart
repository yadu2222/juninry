import 'package:flutter/material.dart';

import 'package:juninry/view/components/atoms/total_point.dart';

// view
import '../atoms/listitem.dart';
// model
import 'package:juninry/models/treasure_model.dart';
// constant
import 'package:juninry/constant/fonts.dart';
import '../../../constant/reward_icon.dart';

class TreasureCard extends StatelessWidget {
  const TreasureCard({
    super.key,
    required this.treasure,
  });

  final Treasure treasure;

  @override
  Widget build(BuildContext context) {
    return ListItem(
        padding: const EdgeInsets.only(left: 10, right: 10),
        widget: IntrinsicHeight(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween, // 両端に寄せる
                crossAxisAlignment: CrossAxisAlignment.center, // 子要素を縦方向に中央揃え
                children: [
              // icon
              Row(children: [
                RewardIcon.getIcon(treasure.reward != null ? treasure.reward!.iconId : 10,
                    border: treasure.reward != null ? treasure.totalPoint == treasure.reward!.rewardPoint : false), // rewardポイントの状態を判別してアイコンに囲み線をつける
                const SizedBox(width: 10), // 余白(アイコンとテキストの間
                // たからばこのタイトル
                Text(
                  treasure.reward != null ? treasure.reward!.rewardName : "空っぽです",
                  style: Fonts.p,
                ),
              ]),
              // 現在のポイント
              TotalPoint(treasure: treasure)
            ])));
  }
}
