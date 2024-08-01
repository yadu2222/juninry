class Exchange {
  final int rewardExchangingId;
  final DateTime exchangeAt;
  final String rewardUuid;
  final String userName;
  final String rewardTitle; // タイトル
  final String rewardContent; // 内容
  final int iconId; // アイコンID
  final bool isExchange;

  Exchange({
    required this.rewardExchangingId,
    required this.exchangeAt,
    required this.rewardUuid,
    required this.userName,
    required this.rewardTitle,
    required this.rewardContent,
    required this.iconId,
    required this.isExchange,
  });

  // DateTimeの解析を安全に行うヘルパー関数
  static DateTime _parseDate(dynamic date) {
    if (date == null) return DateTime.now(); // デフォルト値
    try {
      return DateTime.parse(date.toString());
    } catch (e) {
      // 解析エラーの場合の処理。例: ログ出力やデフォルト値の設定
      print('Date parsing error: $e');
      return DateTime.now(); // デフォルト値
    }
  }

  static List<Exchange> resToExchanges(Map loadData) {
    List<Exchange> exchanges = [];

    try {
      for (Map loadItem in loadData['exchangeData']) {
        exchanges.add(Exchange(
          rewardExchangingId: loadItem['rewardExchangengId'],
          userName: loadItem['userName'] ?? '',
          exchangeAt: _parseDate(loadItem['exchangengAt']),
          rewardUuid: loadItem['rewardData']['rewardUUID'] ?? '',
          rewardTitle: loadItem['rewardData']['rewardTitle'] ?? '',
          rewardContent: loadItem['rewardData']['rewardContent'] ?? '',
          iconId: loadItem['rewardData']['iconId'] ?? 0,
          isExchange: loadItem['isExchange'] == 1, // Assuming 'isExchange' is an int
        ));
      }
    } catch (e) {
      print(e);
    }
    return exchanges;
  }
}
