class Help {
  final String? helpUuid;
  final String helpTitle; // タイトル
  final String helpContent; // 内容
  // final String helpCategory; // カテゴリ
  // final String helpTag; // タグ
  final int iconId; // アイコンID
  final int rewardPoint; // 必要ポイント
  bool? isReword;

  Help({
    this.helpUuid,
    required this.helpTitle,
    required this.helpContent,
    // required this.helpCategory,
    // required this.helpTag,
    required this.iconId,
    required this.rewardPoint,
    this.isReword,
  });

  static List<Help> resToHelps(Map loadData){
    List<Help> helps = [];
    for (Map loadItem in loadData['helpData']) {
      helps.add(Help(
        helpUuid: loadItem['helpUUID'],
        helpTitle: loadItem['helpTitle'],
        helpContent: loadItem['helpContent'],
        iconId: loadItem['iconId'],
        rewardPoint: loadItem['rewardPoint'],
        isReword: loadItem['submittedToday'],
      ));
    }
    return helps;
  }


}
