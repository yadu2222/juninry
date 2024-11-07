import 'package:flutter/material.dart';
import 'package:juninry/constant/colors.dart';
import 'package:juninry/constant/fonts.dart';
import 'package:juninry/constant/reward_icon.dart';
import 'package:juninry/models/reward_model.dart';
import 'package:juninry/view/components/molecule/divider.dart';

class RewardDetail extends StatelessWidget {
  final Reward rewardData;

  const RewardDetail({
    super.key,
    required this.rewardData,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      width: 500,
      height: 150,
      decoration: BoxDecoration(
        color: AppColors.iconLight,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          RewardIcon.getIcon(rewardData.iconId),
          const SizedBox(width: 10), // 余白(アイコンとテキストの間
          Text(rewardData.rewardName, style: Fonts.h4),
        ]),
        const DividerView(
          dividColor: AppColors.main,
          indent: 0,
          endIndent: 0,
        ),
        Text(
          rewardData.note,
          style: Fonts.p,
        ), // 中身
      ]),
    );
  }
}
