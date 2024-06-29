import '../http_req.dart';
import '../../models/user_model.dart';
import '../../constant/urls.dart';
import '../../models/req_model.dart';

class UserService {
  static Future<void> registerUser(Map<String, dynamic> reqBody) async {
    // リクエストを生成
    final reqData = Request(
      url: Urls.registerUser,
      reqType: 'POST',
      body: reqBody,
      headers: {'Content-Type': 'application/json'},
    );
    final resData = await HttpReq.httpReq(reqData);

    // dbに保存するためのオブジェクトを生成
    User user = User(
        userUUID: "ertyui",
        userName: reqBody['userName'],
        userTypeId: reqBody['userTypeId'],
        mailAddress: reqBody['mailAddress'],
        password: reqBody['password'],
        jtiUUID: "aiaueo",
        jwtKey: resData['srvResData']['authenticationToken']);
    User.insertUser(user);  // dbへの保存 getUserでjwtKeyがdbから読み込まれるため

    // ユーザー情報の取得と更新
    user = await getUser();
    User.updateUser(user);
  }

  // ログイン
  static Future<void> login(User user) async {
    // リクエストのオブジェクトを生成
    // ログイン処理
    final reqData = Request(url: Urls.login, reqType: 'POST', body: {'mailAddress': user.mailAddress, 'password': user.password}, headers: {'ContentType': 'application/json'});
    Map resData = await HttpReq.httpReq(reqData); // 投げる

    user.jwtKey = resData['srvResData']['authenticationToken']; // jwtKeyを最新のものに書き換え
    User.updateUser(user); // update
  }

  // ユーザー情報取得
  static Future<User> getUser() async {
    // リクエストを生成
    final reqData = Request(url: Urls.getUser, reqType: 'GET', headers: {'Content-Type': 'application/json'});
    // リクエストメソッドにオブジェクトを投げる
    Map resData = await HttpReq.httpReq(reqData);
    // 返す
    return User.resToUser(resData['srvResData']['userData']);
  }
}
