import 'package:flutter/material.dart';
import '../../../constant/help.dart';
import '../../../constant/fonts.dart';
import '../../../constant/colors.dart';

class QuestionCard extends StatelessWidget {
  final Question question;
  const QuestionCard({super.key, required this.question});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(color: AppColors.iconLight, borderRadius: BorderRadius.circular(10)),
        // padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.only(bottom: 20),
        child: Column(
          children: [
            Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: AppColors.help,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                ),
                padding: const EdgeInsetsDirectional.all(10),
                child: Text('Q.${question.question}', style: Fonts.h5w)),
            Container(alignment: Alignment.centerLeft, padding: const EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 15), child: Text(question.answer, style: Fonts.p)),
          ],
        ));
  }
}
