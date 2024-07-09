import '../http_req.dart';
import '../../models/user_model.dart';
import '../../constant/urls.dart';
import '../../models/req_model.dart';

class NoticeService {
  static Future<User> getNotice() async {
    // リクエストを生成
    final reqData = Request(url: Urls.getNotices, reqType: 'GET', headers: {'Content-Type': 'application/json'});
    // リクエストメソッドにオブジェクトを投げる
    Map resData = await HttpReq.httpReq(reqData);
    // 返す
    return User.resToUser(resData['srvResData']['userData']);
  }
}