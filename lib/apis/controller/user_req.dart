import './http_req.dart';
import '../../models/user_model.dart';
import '../../constant/urls.dart';
import '../../models/req_model.dart';

class UserReq {

  static Future<void> login() async{
    
  }

  static Future<void> getUser() async {
    final reqData = Request(url: urls.user, reqType: 'GET', headers: {'Content-Type': 'application/json'});
    await HttpReq.httpReq(reqData);
  }
}
