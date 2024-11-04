import 'dart:convert';
import 'package:http/http.dart' as http;

class Reward {
  final String? rewardUuid; // GHOUBIのUUID
  final String rewardName; // GHOUBI名
  final String note; // 説明
  final int rewardPoint; // 必要ポイント
  final int iconId; // アイコンID
  final int? stock; // 在庫

  Reward({
    this.rewardUuid,
    required this.rewardName,
    required this.note,
    required this.rewardPoint,
    required this.iconId,
    this.stock,
  });

  static Reward testReward1 = Reward(
    rewardUuid: '1',
    rewardName: 'test1',
    note: 'test1',
    rewardPoint: 100,
    iconId: 1,
    stock: 10,
  );

  static Map<String, dynamic> rewardToMap(Reward reward) {
    return {
      'rewardTitle': reward.rewardName,
      'rewardContent': reward.note,
      'iconId': reward.iconId,
      'rewardPoint': reward.rewardPoint,
    };
  }

  static List<Reward> resToReward(http.Response response) {

    // レスポンスデータをjsonに変換
    Map json = jsonDecode(response.body) as Map<String, dynamic>;
    Map loadData = json['srvResData'] as Map<String, dynamic>;
    List<Reward> rewards = [];
    for (Map loadItem in loadData['rewardData']) {
      rewards.add(Reward(
        rewardUuid: loadItem['rewardUUID'],
        rewardName: loadItem['rewardTitle'],
        note: loadItem['rewardContent'],
        iconId: loadItem['iconId'],
        rewardPoint: loadItem['rewardPoint'],
        // stock: loadItem['stock'],
      ));
    }
    return rewards;
  }
}
