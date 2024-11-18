import 'package:flutter/material.dart';
import 'package:juninry/models/reward_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Treasure {
  final Reward? reward;
  int? totalPoint;
  final ValueNotifier<int?> isOpenNotifier;
  final String boxUuid;

  Treasure({
    this.reward,
    this.totalPoint,
    int? isOpen,
    required this.boxUuid,
  }) : isOpenNotifier = ValueNotifier(isOpen);

  // isOpenのgetterとsetter
  int? get isOpen => isOpenNotifier.value;
  set isOpen(int? value) => isOpenNotifier.value = value;

  static List<Treasure> testTresure = [
    Treasure(
        reward: Reward.testReward1, totalPoint: 100, isOpen: 1, boxUuid: '1'),
    Treasure(totalPoint: 0, isOpen: 0, boxUuid: '2'),
    Treasure(
        reward: Reward.testReward1,
        totalPoint: 0,
        isOpen: 2,
        boxUuid: 'df2b1f4c-b49a-4068-80c5-3120dceb14c8'),
  ];

  static List<Treasure> resToTreasures(http.Response response) {
    // レスポンスデータをjsonに変換
    Map resData = jsonDecode(response.body) as Map<String, dynamic>;

    List<Treasure> treasures = [];
    debugPrint(resData.toString());
    if (resData['srvResData']['boxes'] != null) {
      for (Map<String, dynamic> loadData in resData['srvResData']?['boxes']) {
        final rewardMap = loadData['reward'] as Map<String, dynamic>?;
        Reward? reward;
        if (rewardMap != null) {
          reward = Reward(
              rewardName: rewardMap['rewardTitle'],
              note: rewardMap['rewardContent'],
              rewardPoint: rewardMap['rewardPoint'],
              iconId: rewardMap['iconId']);
        }

        treasures.add(Treasure(
            reward: reward,
            totalPoint: loadData['depositPoint'] ?? 0,
            isOpen: loadData['boxStatus'] ?? 0,
            boxUuid: loadData['hardwareUUID'] ?? ''));
      }
    }
    return treasures;
  }
}
