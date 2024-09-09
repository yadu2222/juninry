import 'class_model.dart';

class NoticeFilter {
  String userUUID;
  String userName;
  List<Class> classes;

  NoticeFilter({required this.userUUID, required this.userName, required this.classes});

  // レスポンスの整形
  static List<NoticeFilter> resToNoticeFilters(List<Map<String, dynamic>> loadData) {
    List<NoticeFilter> noticeFilters = [];
    for (Map loadItem in loadData) {
      noticeFilters.add(NoticeFilter(
          userUUID: loadItem['childUUID'],
          userName: loadItem['childName'],
          classes: Class.resToClasses(loadItem['classes'])));
    }
    return noticeFilters;
  }
}