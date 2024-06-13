import 'package:flutter/widgets.dart';
import 'package:juninry/constant/colors.dart';
import 'package:juninry/view/components/molecule/divider.dart';

import 'package:flutter/material.dart';

import '../../../models/notice_model.dart';

import '../../../constant/fonts.dart';

class QuoteFromNotice extends StatelessWidget {
  final String quoteNoticeTitle;
  const QuoteFromNotice({super.key, required this.quoteNoticeTitle});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.iconLight,
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(2.0)),
          ),
        ),
        onPressed: () {
          print("Tapされました");
        },
        child: Column(
          children: [
            Row(children: [
              const Icon(Icons.attach_file, color: AppColors.iconDark),
              Text(quoteNoticeTitle, style: Fonts.p),
            ]),
            const Divider(
              thickness: 2,
              color: AppColors.main,
              indent: 0,
              endIndent: 0,
            )
          ],
        ));
  }
}
