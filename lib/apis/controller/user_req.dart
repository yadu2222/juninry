import './http_req.dart';
import '../../models/user_model.dart';
import '../../constant/urls.dart';
import '../../models/req_model.dart';

class UserReq {
  // ユーザー登録
  static Future<void> registerUser(Map<String, dynamic> registerUser) async {
    // TODO:入力ふぉーむ
    // {
    //   "userName": "test teacher",
    //   "userTypeId": 1,
    //   "mailAddress": "test-teacher@gmail.com",
    //   "password": "C@tt"
    // }

    // testData
    Map<String, dynamic> testBody = {"userName": "yaduko", "userTypeId": 1, "mailAddress": "yadukolpko@gmail.com", "password": "C@tt"};
    // リクエストのオブジェクトを生成
    final reqData = Request(url: Urls.registerUser, reqType: 'POST', body: testBody, headers: {'Content-Type': 'application/json'});
    // リクエストメソッドにオブジェクトを投げる
    Map resData = await HttpReq.httpReq(reqData);

    // 登録後、getUserを行い、ユーザーの情報をdbに保存
    // formから取得した値を保存
    User user = User(userUUID: "aiueaoo", userName:testBody['userName'], userTypeId: 1, mailAddress: testBody['mailAddress'], password: "C@tt", jtiUUID: "aiaueo", jwtKey: resData['srvResData']['authenticationToken']);
    User.insertUser(user);
    // login(user);  // 登録したauthを元にlogin
  }

  // ログイン
  // TODO:updの処理
  static Future<void> login(User? user) async {
    user = user ?? await User.getUser(); // 引数がnullであればuser情報をdbから取得
    // リクエストのオブジェクトを生成
    // ログイン処理
    print(user.mailAddress);
    final reqData = Request(url: Urls.login, reqType: 'POST', body: {'mailAddress':user.mailAddress, 'password': user.password}, headers: {'ContentType': 'application/json'});
    Map resData = await HttpReq.httpReq(reqData); // 投げる

    // TODO:dbのauthを更新
    user.jwtKey = resData['srvResData']['authenticationToken']; // jwtKeyを最新のものに書き換え
    User.updateUser(user);  // update
  }

  // ユーザー情報取得
  static Future<User> getUser() async {
    // リクエストのオブジェクトを生成
    final reqData = Request(url: Urls.getUser, reqType: 'GET', headers: {'Content-Type': 'application/json'});
    // リクエストメソッドにオブジェクトを投げる
    Map resData = await HttpReq.httpReq(reqData);
    // レスポンスの処理
    // 返す
    // TODO:エラーハンドリング
    return User.resToUser(resData['srvResData']['userData']);
  }
}
