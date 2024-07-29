class Ouchi {
  String? ouchiUUID;
  String ouchiName;
  String inviteCode;

  Ouchi({this.ouchiUUID, required this.ouchiName, required this.inviteCode});

  // レスポンスデータをおうち情報に変換
  static Ouchi resToOuchi(Map loadData) {
    Ouchi ouchi = Ouchi(ouchiName: loadData['ouchiName'], inviteCode: loadData['inviteCode']);

    return ouchi;
  }
}
