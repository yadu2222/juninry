import 'package:flutter/material.dart';
import 'package:juninry/models/homework_submission_record.dart';
import '../../../constant/colors.dart';

class LifeGauge extends StatelessWidget {
  final int life;

  LifeGauge({super.key, required List<HomeworkSubmissionRecord> record})
      : life = _calculateLife(record);

  static int _calculateLife(List<HomeworkSubmissionRecord> record) {
    int count = 3;
    for (HomeworkSubmissionRecord data in record) {
      if (data.homeworkCount > data.submissionCount &&
          data.limitDate.isBefore(DateTime.now())) {
        count -= 1;
      }
      if (count == 0) break;
    }
    debugPrint("life: $count");
    return count;
  }

  List<Widget> _buildLifeIcons() {
    return List.generate(
        3,
        (i) => Icon(i < life ? Icons.favorite : Icons.heart_broken_outlined,
            size: 50, color: AppColors.main));
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: _buildLifeIcons(),
    );
  }
}
