import '../http_req.dart';
import '../../models/req_model.dart';
import '../../constant/urls.dart';
import '../../models/quoted_notice_model.dart';

class NoticeService {
  static Future<QuotedNotice> fetchQuotedNotice(String noticeUuid) async {
    // リクエストのオブジェクトを生成
    final reqData = Request(
        url: Urls.noticeDetail + noticeUuid,
        reqType: 'GET',
        headers: {}); // HACK: 空のヘッダー定義しないとエラーでこける

    Map resData = await HttpReq.httpReq(reqData);
    return QuotedNotice.resToQuotedNotice(resData);
  }
}
