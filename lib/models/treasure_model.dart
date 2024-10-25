import 'package:juninry/models/reward_model.dart';

class Treasure {
  final Reward reward;
  final int totalPoint;
  final bool isOpen;
  final String boxUuid;

  Treasure({
    required this.reward,
    required this.totalPoint,
    required this.isOpen,
    required this.boxUuid,
  });

  static List<Treasure> testTresure = [
    Treasure(reward: Reward.testReward1, totalPoint: 100, isOpen: true,boxUuid: '1'),
  ];
}
