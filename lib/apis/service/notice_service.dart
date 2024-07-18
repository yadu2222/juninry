import '../../models/req_model.dart';
import '../../constant/urls.dart';
import '../../models/quoted_notice_model.dart';
import '../../models/notice_model.dart';
import 'package:http/http.dart' as http;
import '../error.dart';
import '../http_req.dart';

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
  
  static Future<QuotedNotice> getQuotedNotice(String noticeUuid) async {
    // リクエストのオブジェクトを生成
    final reqData = Request(
        url: Urls.noticeDetail + noticeUuid,
        reqType: 'GET',
        headers: {}); // HACK: 空のヘッダー定義しないとエラーでこける

    Map resData = await HttpReq.httpReq(reqData);
    return QuotedNotice.resToQuotedNotice(resData);
  }

  static Future<void> registerNotice(Notice notice) async {
    final reqData = Request(url: Urls.noticeRegister, reqType: 'POST', body: {
      "noticeTitle": notice.noticeTitle,
      "noticeExplanatory": notice.noticeExplanatory,
      "classUUID": notice.classUUID,
      if (notice.quotedNoticeUUID != null)
        "quotedNoticeUUID": notice.quotedNoticeUUID
    }, headers: {
      'Content-Type': 'application/json'
    });
    await HttpReq.httpReq(reqData);

  }
}
