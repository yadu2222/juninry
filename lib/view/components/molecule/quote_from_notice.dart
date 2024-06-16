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
    return MaterialButton(
      color: AppColors.iconLight,
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
      ),
      elevation: 0, //ボタンの影を消す
      highlightElevation: 0, //ボタンの影を消す
      splashColor: Colors.transparent,
      onPressed: () {},
      child: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Column(
            children: [
              Row(children: [
                const Icon(Icons.attach_file, color: AppColors.iconDark),
                Text(quoteNoticeTitle, style: Fonts.p),
              ]),
              const Divider(
                thickness: 2,
                color: AppColors.main,
                height: 3,
                indent: 0,
                endIndent: 0,
              )
            ],
          )),
    );
  }
}
