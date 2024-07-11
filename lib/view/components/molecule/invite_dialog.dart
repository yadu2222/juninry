import 'package:flutter/material.dart';
import '../../../constant/fonts.dart';
import '../../../constant/colors.dart';
import '../atoms/dialog.dart';
import '../../../models/class_model.dart' as inviteClass;

// 招待コードの表示
// TODO:デザイン
inviteDialog(BuildContext context, inviteClass.Class resData) {
  DialogUtil.show(
      isBarrier: true,
      context: context,
      child: Container(
        padding: const EdgeInsets.all(20),
        width: 500,
        height: 150,
        decoration: BoxDecoration(
          color: AppColors.iconLight,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text(
            '作成に成功しました！',
            style: Fonts.py,
          ),
          Text(
            '${resData.className}の招待コードは',
            style: Fonts.h4,
          ),

          Text(
            resData.inviteCode!,
            style: Fonts.h1,
          ),
          const Text(
            '次のAM4:00まで有効です',
            style: Fonts.h1r,
          )
        ]),
      ));
}
