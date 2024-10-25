import 'package:flutter/material.dart';
import 'package:juninry/constant/fonts.dart';
import 'package:juninry/models/treasure_model.dart';

// ポイント表示
class TotalPoint extends StatelessWidget {
  const TotalPoint({super.key, required this.treasure});

  final Treasure treasure;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 30,
        margin: const EdgeInsets.all(10),
        child: Row(
          children: [
            Text(treasure.totalPoint.toString(), style: Fonts.totalPoint),
            Padding(
                padding: const EdgeInsets.only(right: 3, left: 3),
                child: Transform.rotate(
                  angle: 10 * 3.14 / 180,
                  child: const Text("/", style: Fonts.point),
                )),
            Text(treasure.reward.rewardPoint.toString(), style: Fonts.point),
          ],
        ));
  }
}
