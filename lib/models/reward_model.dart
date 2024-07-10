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
}
