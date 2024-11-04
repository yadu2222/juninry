import 'dart:convert';
import 'package:http/http.dart' as http;

class HomeworkSubmissionRecord {
  final DateTime limitDate;
  final int homeworkCount;
  final int submissionCount;

  const HomeworkSubmissionRecord({
    required this.limitDate,
    required this.homeworkCount,
    required this.submissionCount,
  });

  static List<HomeworkSubmissionRecord> resToHomeworkSubmissionRecords (http.Response response) {

    Map json = jsonDecode(response.body) as Map<String, dynamic>;
    List<Map> resData = json['srvResData'];

    List<HomeworkSubmissionRecord> homeworkSubmissionRecords = [];
    for (Map data in resData) {
      homeworkSubmissionRecords.add(HomeworkSubmissionRecord(
        limitDate: DateTime.parse(data['limitDate']),
        homeworkCount: data['homeworkCount'],
        submissionCount: data['submissionCount'],
      ));
    }
    return homeworkSubmissionRecords;
  }
}