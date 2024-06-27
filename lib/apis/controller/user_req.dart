import './http_req.dart';
import '../../models/user_model.dart';
import '../../constant/urls.dart';
import '../../models/req_model.dart';

class UserReq {

  static Future<void> login() async{
    
  }

  static Future<void> getUser() async {

    // リクエストのオブジェクトを生成
    final reqData = Request(url: Urls.getUser, reqType: 'GET', headers: {'Content-Type': 'application/json'});
    // リクエストメソッドにオブジェクトを投げる
    await HttpReq.httpReq(reqData);
  }
}
