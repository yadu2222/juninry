import 'package:flutter/material.dart';
import 'package:juninry/models/homework_submission_record.dart';
import '../../../constant/colors.dart';

class SubmissionRecordDot extends StatelessWidget {
  final HomeworkSubmissionRecord record;

  const SubmissionRecordDot({required this.record});

  Widget typeIcon() {
    if (record.homeworkCount == record.submissionCount) {
      return const Icon(
        Icons.brightness_1,
        color: AppColors.main,
        size: 10,
      );
    } else if (record.limitDate.isAfter(DateTime.now())) {
      return const Icon(
        Icons.brightness_1_outlined,
        color: AppColors.main,
        size: 10,
      );
    } else {
      return const Icon(
        Icons.brightness_1_outlined,
        color: AppColors.iconDark,
        size: 10,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return typeIcon();
  }
}
