import 'package:flutter/material.dart';
import '../../../constant/colors.dart';

// 色の透明度を変更する関数
Color changeColorOpacity(int record) {
  return Color.fromARGB(255, 111, 111, 111);
}

class SubmissionRecordDot extends StatelessWidget {
  final int record;

  const SubmissionRecordDot({required this.record});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 5,
      height: 5,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: changeColorOpacity(record),
      ),
    );
  }
}
