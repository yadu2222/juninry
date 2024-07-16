import '../http_req.dart';
import '../../models/notice_model.dart';
import '../../constant/urls.dart';
import '../../models/req_model.dart';

class NoticeService {
  static Future<List<Notice>> getNotices() async {
    try {
      // リクエストを生成
      final reqData = Request(
          url: Urls.getNotices,
          reqType: 'GET',
          headers: {'Content-Type': 'application/json'});
      // リクエストメソッドにオブジェクトを投げる
      Map resData = await HttpReq.httpReq(reqData);

      // 通知が存在するか確認
      print('おこられちゃう」～～');
      print(resData.toString());
   
        // 通知リストを返す
        return Notice.resToNotices(resData['srvResData']['notices']);
     
    } catch (e) {

      print("じつはよ、、例外がでてるんだ");
      print(e.toString());
      // エラーメッセージを出力
      // エラーが発生した場合にエラーメッセージをリストで返す
      return [Notice.errorNotice()];
    }
  }
}
