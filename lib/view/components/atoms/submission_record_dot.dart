import 'package:flutter/material.dart';
import 'package:juninry/models/homework_submission_record.dart';
import '../../../constant/colors.dart';

// 色の透明度を変更する関数
Color changeColorOpacity(bool record) {
  return Color.fromARGB(255, 111, 111, 111);
}

class SubmissionRecordDot extends StatelessWidget {
  final HomeworkSubmissionRecord record;

  const SubmissionRecordDot({required this.record});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 5,
      height: 5,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: changeColorOpacity(true),
      ),
    );
  }
}
