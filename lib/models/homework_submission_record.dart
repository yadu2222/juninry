class HomeworkSubmissionRecord {
  final DateTime limitDate;
  final int homeworkCount;
  final int submissionCount;

  const HomeworkSubmissionRecord({
    required this.limitDate,
    required this.homeworkCount,
    required this.submissionCount,
  });

  static List<HomeworkSubmissionRecord> resToHomeworkSubmissionRecords (List resData) {
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