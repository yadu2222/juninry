import 'package:flutter/material.dart';
import 'package:juninry/constant/colors.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({
    Key? key,
    required this.progress,
  }) : super(key: key);

  final double progress;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.875,
        margin: const EdgeInsets.only(top: 10, bottom: 10),
        // padding: const EdgeInsets.only(top: 10, bottom: 10),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(11)),
          border: Border.all(
            color: AppColors.subjectSocial,
          ),
        ),
        child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            child: LinearProgressIndicator(
              backgroundColor: AppColors.iconLight,
              valueColor: const AlwaysStoppedAnimation<Color>(AppColors.subjectSocial),
              minHeight: 30,
              value: progress,
            )));
  }
}
