import 'package:flutter/material.dart';
import 'package:juninry/constant/colors.dart';
import 'package:juninry/models/reward_detail.dart';
// view
import '../atoms/listitem.dart';
import '../atoms/basic_button.dart';
// model
import '../../../models/reward_model.dart';
// constant
import 'package:juninry/constant/fonts.dart';
import '../../../constant/reward_icon.dart';
import '../atoms/dialog.dart';
import './divider.dart';

class RewardCard extends StatelessWidget {
  const RewardCard({
    super.key,
    required this.rewardData,
    required this.isRewardPoint,
    this.buy,
  });

  final Reward rewardData;
  final bool isRewardPoint;
  final void Function(Reward)? buy;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          // 詳細を表示
          // TODO:なにをのせるか決まったら切り分け
          DialogUtil.show(
              isBarrier: true,
              context: context,
              child: RewardDetail(rewardData: rewardData));
          // Container(
          //   padding: const EdgeInsets.all(20),
          //   width: 500,
          //   height: 150,
          //   decoration: BoxDecoration(
          //     color: AppColors.iconLight,
          //     borderRadius: BorderRadius.circular(10),
          //   ),
          //   child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          //     Row(children: [
          //       RewardIcon.getIcon(rewardData.iconId),
          //       const SizedBox(width: 10), // 余白(アイコンとテキストの間
          //       Text(rewardData.rewardName, style: Fonts.h4),
          //     ]),
          //     const DividerView(
          //       dividColor: AppColors.main,
          //       indent: 0,
          //       endIndent: 0,
          //     ),
          //     Text(
          //       rewardData.note,
          //       style: Fonts.p,
          //     ) // 中身
          //   ]),
          // ));
        },
        child: ListItem(
            padding: const EdgeInsets.only(left: 10, right: 10),
            widget: IntrinsicHeight(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween, // 両端に寄せる
                    crossAxisAlignment:
                        CrossAxisAlignment.center, // 子要素を縦方向に中央揃え
                    children: [
                  // icon
                  Row(children: [
                    RewardIcon.getIcon(rewardData.iconId),
                    const SizedBox(width: 10), // 余白(アイコンとテキストの間
                    // おてつだいのタイトル
                    Text(
                      rewardData.rewardName,
                      style: Fonts.p,
                    ),
                  ]),
                  // 交換ボタン
                  // juniorでのみ表示
                  BasicButton(
                      iconSize: 20,
                      margin: const EdgeInsets.only(
                        top: 7,
                        bottom: 7,
                      ),
                      width: 0.3,
                      icon: isRewardPoint
                          ? Icons.local_offer
                          : Icons.sentiment_dissatisfied_rounded,
                      text: '${rewardData.rewardPoint.toString()}P',
                      isColor: isRewardPoint,
                      onPressed: () {
                        if (buy != null) {
                          buy!(rewardData);
                        }
                      })
                ]))));
  }
}
