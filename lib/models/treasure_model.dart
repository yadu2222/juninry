import 'package:flutter/material.dart';
import 'package:juninry/models/reward_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Treasure {
  final Reward? reward;
  int totalPoint;
  final bool isOpen;
  final String boxUuid;

  Treasure({
    this.reward,
    required this.totalPoint,
    required this.isOpen,
    required this.boxUuid,
  });

  static List<Treasure> testTresure = [
    Treasure(
        reward: Reward.testReward1,
        totalPoint: 100,
        isOpen: true,
        boxUuid: '1'),
    Treasure(totalPoint: 0, isOpen: false, boxUuid: '2'),
    Treasure(
        reward: Reward.testReward1,
        totalPoint: 0,
        isOpen: false,
        boxUuid: 'df2b1f4c-b49a-4068-80c5-3120dceb14c8'),
  ];

  static List<Treasure> resToTreasures(http.Response response) {
    // レスポンスデータをjsonに変換
    Map resData = jsonDecode(response.body) as Map<String, dynamic>;

    List<Treasure> treasures = [];
    debugPrint(resData.toString());
    if (resData['srvResData']['boxes'] != null) {
      for (Map<String, dynamic> loadData in resData['srvResData']?['boxes']) {
        treasures.add(Treasure(
            reward: Reward(
              rewardName: loadData['reward']?['rewardTitle'] ?? '',
              rewardPoint: loadData['reward']?['rewardPoint'] ?? 0,
              note: loadData['reward']?['rewardContent'] ?? '',
              iconId: loadData['reward']?['iconId'] ?? 0,
              stock: loadData['reward']?['stock'] ?? 0,
            ),
            totalPoint: loadData['depositPoint'] ?? 0,
            isOpen: loadData['isOpen'] ?? false,
            boxUuid: loadData['hardwareUUID'] ?? ''));
      }
    }
    return treasures;
  }
}
