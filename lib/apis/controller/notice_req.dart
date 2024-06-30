import '../service/notice_service.dart';
import '../../models/quoted_notice_model.dart';

class NoticeReq {
  static Future<QuotedNotice> fetchQuotedNotice(String noticeUuid) async {
    try {
      return NoticeService.fetchQuotedNotice(noticeUuid);
    } catch (error) {
      return QuotedNotice.errorQuotedNotice();
    }
  }
}
