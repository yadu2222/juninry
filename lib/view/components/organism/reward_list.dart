import 'package:flutter/material.dart';
import 'package:juninry/models/reward_model.dart';
import '../atoms/listItem_box.dart';
import '../molecule/reward_card.dart';

// おてつだいリスト
class RewardList extends StatelessWidget {
  final int rewardPoint;
  final bool isJunior;
  final List<Reward> rewards;

  final void Function(Reward)? buy;

  const RewardList({
    super.key,
    required this.isJunior,
    required this.rewardPoint,
    required this.rewards,
    this.buy,
  });

  @override
  Widget build(BuildContext context) {
    return ListItemBox<Reward>(
      itemDatas: rewards,
      listItem: (reward) => RewardCard(rewardData: reward, buy: buy, isRewardPoint: rewardPoint >= reward.rewardPoint),
    );
  }
}
