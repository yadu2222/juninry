class Reward {
  final String? rewardUuid; // GHOUBIのUUID
  final String rewardName;  // GHOUBI名
  final String note;      // 説明
  final int rewardPoint;  // 必要ポイント

  Reward({
    this.rewardUuid,
    required this.rewardName,
    required this.note,
    required this.rewardPoint,
  });
}