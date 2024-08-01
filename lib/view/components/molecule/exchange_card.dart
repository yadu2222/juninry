import 'package:flutter/material.dart';
import "package:intl/intl.dart";
// view
import '../atoms/listitem.dart';
import '../atoms/basic_button.dart';
// model
import '../../../models/exchange_model.dart';
// constant
import 'package:juninry/constant/fonts.dart';
import '../../../constant/reward_icon.dart';
import '../atoms/dialog.dart';
import './divider.dart';
import 'package:juninry/constant/colors.dart';

class ExchangeCard extends StatelessWidget {
  const ExchangeCard({super.key, required this.exchangeData, this.exchange, required this.isJunior});

  final Exchange exchangeData;
  final bool isJunior;
  final void Function(Exchange)? exchange;

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
                    RewardIcon.getIcon(exchangeData.iconId),
                    const SizedBox(width: 10), // 余白(アイコンとテキストの間
                    Text(exchangeData.rewardTitle, style: Fonts.h4),
                  ]),
                  const DividerView(
                    dividColor: AppColors.main,
                    indent: 0,
                    endIndent: 0,
                  ),
                  Text(
                    exchangeData.rewardContent,
                    style: Fonts.p,
                  ),
                  const SizedBox(height: 5),
                  Row(children: [
                    const Icon(
                      Icons.person,
                      size: 20,
                    ),
                    const SizedBox(width: 5), // 余白(アイコンとテキストの間
                    Text(
                      exchangeData.userName,
                      style: Fonts.p,
                    )
                  ])
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
                    // おてつだいの日付
                    Text(
                      DateFormat('MM.dd').format(exchangeData.exchangeAt),
                      style: Fonts.pg,
                    ),
                    const SizedBox(width: 10), // 余白(アイコンとテキストの間
                    RewardIcon.getIcon(exchangeData.iconId),
                    const SizedBox(width: 10), // 余白(アイコンとテキストの間
                    // おてつだいのタイトル
                    Text(
                      exchangeData.rewardTitle,
                      style: Fonts.p,
                    ),
                  ]),
                  // 交換ボタン
                  // patronでのみ表示
                  BasicButton(
                      iconSize: 20,
                      margin: const EdgeInsets.only(
                        top: 7,
                        bottom: 7,
                      ),
                      width: 0.2,
                      icon: exchangeData.isExchange ? Icons.check : Icons.local_offer,
                      isColor: exchangeData.isExchange,
                      onPressed: () {
                        exchange?.call(exchangeData);
                      })
                ]))));
  }
}
