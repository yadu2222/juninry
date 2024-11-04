import 'package:juninry/models/user_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Ouchi {
  String? ouchiUUID;
  String ouchiName;
  String? inviteCode;
  List<User>? members;

  Ouchi(
      {this.ouchiUUID,
      required this.ouchiName,
      required this.inviteCode,
      this.members});

  static Ouchi errorOuchi() {
    return Ouchi(ouchiUUID: '', ouchiName: '', inviteCode: '');
  }

  // レスポンスデータをおうち情報に変換
  static Ouchi resToOuchi(http.Response response) {

    // レスポンスデータをjsonに変換
    Map json = jsonDecode(response.body) as Map<String, dynamic>;
    Map loadData = json['srvResData'] as Map<String, dynamic>;

    Ouchi ouchi = Ouchi(
      ouchiName: loadData['ouchiName'],
      ouchiUUID: loadData['ouchiUUID'] as String?,
      inviteCode: loadData['inviteCode'] as String?,
    );

    ouchi.members = [];
    for (Map member in loadData['ouchiMembers']) {
      ouchi.members!.add(User.mapToUser(member));
    }
    return ouchi;
  }
}
