import 'package:juninry/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:juninry/constant/fonts.dart';

class QuoteFromNotice extends StatelessWidget {
  final String quoteNoticeTitle;
  const QuoteFromNotice({super.key, required this.quoteNoticeTitle});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: AppColors.iconLight,
      padding: const EdgeInsets.symmetric(horizontal: 3),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
      ),
      elevation: 0, //ボタンの影を消す
      highlightElevation: 0, //ボタンの影を消す
      splashColor: Colors.transparent,
      // TODO: 引用するお知らせ選択画面への遷移
      onPressed: () {},
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.zero,
            child: Row(children: [
              const Icon(
                Icons.attach_file,
                color: AppColors.iconGray,
                weight: 5,
              ),
              Text(quoteNoticeTitle, style: Fonts.p),
            ]),
          ),
          const Divider(
            height: 5,
            thickness: 3.5,
            color: AppColors.main,
            indent: 0,
            endIndent: 0,
          )
        ],
      ),
    );
  }
}
