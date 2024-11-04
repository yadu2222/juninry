import 'dart:convert';
import 'package:http/http.dart' as http;
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

  static Map<String,dynamic> helpToMap(Help help){
    return {
      'helpTitle': help.helpTitle,
      'helpContent': help.helpContent,
      'iconId': help.iconId,
      'rewardPoint': help.rewardPoint,
    };
  }

  static List<Help> resToHelps(http.Response response) {

    // レスポンスデータをjsonに変換
    Map loadData = jsonDecode(response.body) as Map<String, dynamic>;

    List<Help> helps = [];
    for (Map loadItem in loadData['srvResData']['helpData']) {
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
