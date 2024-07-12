import 'package:flutter/material.dart';
import 'package:juninry/models/reward_model.dart';
// import 'package:go_router/go_router.dart';

import '../atoms/listItem_box.dart';
import '../molecule/reward_card.dart';
import '../molecule/divider.dart';

// おてつだいリスト
class RewardList extends StatelessWidget {
  final int rewardPoint;
  final bool isJunior;
  final List<Reward> rewards;

  final void Function(Reward) buy;

  const RewardList({
    super.key,
    required this.isJunior,
    required this.rewardPoint,
    required this.rewards,
    required this.buy,
  });

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const DividerView(
        icon: Icons.auto_awesome,
        title: 'GOHOUBI',
      ),
      ListItemBox<Reward>(
        itemDatas: rewards,
        listItem: (reward) => RewardCard(rewardData: reward, onTap: buy, isRewardPoint: rewardPoint >= reward.rewardPoint),
      )
    ]);
  }
}
