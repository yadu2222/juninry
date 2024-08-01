import '../http_req.dart';
import '../../constant/urls.dart';
import '../../models/req_model.dart';
// import 'package:http/http.dart' as http;
// import '../error.dart';
import '../../models/user_model.dart';
import '../../models/ouchi_model.dart';

class OUCHIService {
  // おうち作成
  static Future<Ouchi> createOuchi(String ouchiName) async {
    // TODO:エラーハンドリング
    // リクエストを生成
    final reqData = Request(
      url: Urls.createOUCHI,
      reqType: 'POST',
      body: {'ouchiName': ouchiName},
      headers: {'Content-Type': 'application/json'},
    );
    final resData = await HttpReq.httpReq(reqData);

    // user情報を更新
    User user = await User.getUser();
    user.ouchiUUID = resData['srvResData']['ouchiUUID'];
    await User.updateUser(user);
    return Ouchi.resToOuchi(resData['srvResData']); // おうちデータを返す
  }

  // lineアカウントと連携
  static Future<String> friendLineAccount() async {
    // TODO:エラーハンドリング
    // リクエストを生成
    final reqData = Request(url: Urls.friendLineAccount, reqType: 'GET', headers: {});
    final resData = await HttpReq.httpReq(reqData);
    return resData['url']; // おうちデータを返す
  }
}
