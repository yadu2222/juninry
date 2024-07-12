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
      if (resData['notices'] != null && resData['notices'].isNotEmpty) {
        // 通知リストを返す
        return Notice.resToNotices(List<Map<String, dynamic>>.from(resData['notices']));
      } else {
        // 通知が存在しない場合にエラーメッセージを返す
        return [Notice.errorNotice()];
      }
    } catch (e) {
      // エラーメッセージを出力
      // エラーが発生した場合にエラーメッセージをリストで返す
      return [Notice.errorNotice()];
    }
  }
}
