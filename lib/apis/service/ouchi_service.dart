import '../http_req.dart';
import '../../constant/urls.dart';
import '../../models/req_model.dart';
// import 'package:http/http.dart' as http;
// import '../error.dart';

class OUCHIService {

  // おうち作成
  static Future<String> createOuchi(String ouchiName) async {
    // TODO:エラーハンドリング
     // リクエストを生成
    final reqData = Request(
      url: Urls.createOUCHI,
      reqType: 'POST',
      body: {'className': ouchiName},
      headers: {'Content-Type': 'application/json'},
    );
    final resData = await HttpReq.httpReq(reqData);
    return resData['srvResData']['ouchiName'];
  }

  // 現在のポイントを取得

  // お手伝いを追加

  // お手伝いを消化

  // お手伝いを削除

  // お手伝いを取得

  // ご褒美を追加

  // ご褒美を交換

  // ご褒美を削除

  // ご褒美を取得

  
}
