import 'package:http/http.dart' as http;
import '../http_req.dart';
import '../../models/req_model.dart';
import '../../constant/urls.dart';
import '../error.dart';
// model
import '../../models/user_model.dart';



class UserService {
  static Future<void> registerUser(Map<String, dynamic> reqBody) async {
    // リクエストを生成
    final reqData = Request(
      url: Urls.registerUser,
      reqType: 'POST',
      body: reqBody,
      headers: {'Content-Type': 'application/json'},
    );
    print('damedesu');
    final resData = await HttpReq.httpReq(reqData, false);
    print('damedesu');
    // dbに保存するためのオブジェクトを生成
    User user = User(
        userName: reqBody['userName'], userTypeId: reqBody['userTypeId'], mailAddress: reqBody['mailAddress'], password: reqBody['password'], jwtKey: resData['srvResData']['authenticationToken']);
    User.insertUser(user); // dbへの保存 getUserでjwtKeyがdbから読み込まれるため

    // ユーザー情報の取得と更新
    user = await getUser();
    // User.updateUser(user);
  }

  // ログイン
  static Future<void> login(User user) async {
    // リクエストのオブジェクトを生成
    // ログイン処理
    final reqData = Request(url: Urls.login, reqType: 'POST', body: {'mailAddress': user.mailAddress, 'password': user.password}, headers: {'ContentType': 'application/json'});
    Map resData = await HttpReq.httpReq(reqData); // 投げる

    user.jwtKey = resData['srvResData']['authenticationToken']; // jwtKeyを最新のものに書き換え

    // user情報がすでに存在しているかを判別して場合分け
    User check = await User.getUser();
    // user情報が存在していない場合
    if (check.userName == '') {
      User.insertUser(user); // 一時的に追加
      User updUser = await getUser();
      updUser.jwtKey = user.jwtKey;
      updUser.ouchiUUID = user.ouchiUUID;
      User.updateUser(updUser); // update
    } else {
      User.updateUser(user);
    }
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

  // OUCHIに参加
  // 結果的に操作するのはuserモデルなのになあのきもち
  static Future<String> joinOUCHI(
    String inviteCode,
  ) async {
    errorHandling(http.Response response) {
      if (response.statusCode == 403) {
        throw const PermittionError(); // 親にはその権限がないよ
      } else if (response.statusCode == 409) {
        throw const JoinClassConflictException(); // すでに参加している場合をthrow
      } else {
        throw Exception('おうち参加に失敗しました');
      }
    }

    // リクエストを生成
    final reqData = Request(
      url: Urls.joinOUCHI,
      reqType: 'POST',
      parData: inviteCode,
      headers: {'Content-Type': 'application/json'},
      errorHandling: errorHandling,
    );
    final resData = await HttpReq.httpReq(reqData);
    // ユーザー情報の更新
    await getUser();
    return resData['srvResData']['ouchiName'];
  }
}
