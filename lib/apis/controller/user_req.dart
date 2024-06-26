import './http_req.dart';
import '../../constant/urls.dart';
import '../../models/req_model.dart';

class UserReq {
  static Future<void> getUser() async {
    final reqData = Request(
      url: urls.user,
      reqType: 'GET',
    );
    await HttpReq.httpReq(reqData);
  }
}
