import 'package:flutter/material.dart';
import 'package:juninry/constant/colors.dart';
// view
import '../atoms/listitem.dart';
import '../atoms/basic_button.dart';
// model
import '../../../models/help_model.dart';
// constant
import 'package:juninry/constant/fonts.dart';
import '../../../constant/help_icon.dart';
import '../atoms/dialog.dart';
import './divider.dart';

class HelpCard extends StatelessWidget {
  const HelpCard({
    super.key,
    required this.helpData,
    required this.onTap,
  });

  final Help helpData;
  final void Function(Help)? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          // 詳細を表示
          // TODO:なにをのせるか決まったら切り分け
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
                  Row(children: [
                    HelpIcon.getIcon(helpData.iconId),
                    const SizedBox(width: 10), // 余白(アイコンとテキストの間
                    Text(helpData.helpTitle, style: Fonts.h4),
                  ]),
                  const DividerView(
                    dividColor: AppColors.main,
                    indent: 0,
                    endIndent: 0,
                  ),
                  Text(
                    helpData.helpContent,
                    style: Fonts.p,
                  ) // 中身
                ]),
              ));
        },
        child: ListItem(
            padding: const EdgeInsets.only(left: 10, right: 10),
            widget: IntrinsicHeight(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween, // 両端に寄せる
                    crossAxisAlignment: CrossAxisAlignment.center, // 子要素を縦方向に中央揃え
                    children: [
                  // icon
                  Row(children: [
                    HelpIcon.getIcon(helpData.iconId),
                    const SizedBox(width: 10), // 余白(アイコンとテキストの間
                    // おてつだいのタイトル
                    Text(
                      helpData.helpTitle,
                      style: Fonts.p,
                    ),
                  ]),
                  // できたよボタン
                  // juniorでのみ表示
                  BasicButton(
                      margin: const EdgeInsets.only(
                        top: 7,
                        bottom: 7,
                      ),
                      width: 0.3,
                      icon: helpData.isReword! ? Icons.check : Icons.military_tech,
                      text: '${helpData.rewardPoint.toString()}P',
                      isColor: !helpData.isReword!,
                      onPressed: () {
                        // 未達成であれば
                        if (!helpData.isReword!) {
                          if (onTap != null) {
                            onTap!(helpData);
                          }
                        }
                      })
                ]))));
  }
}
