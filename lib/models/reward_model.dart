class Reward {
  final String? rewardUuid; // GHOUBIのUUID
  final String rewardName; // GHOUBI名
  final String note; // 説明
  final int rewardPoint; // 必要ポイント
  final int iconId;     // アイコンID
  final int? stock;     // 在庫

  Reward({
    this.rewardUuid,
    required this.rewardName,
    required this.note,
    required this.rewardPoint,
    required this.iconId,
    this.stock,
  });

  static List<Reward> resToReward(Map loadData) {
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
