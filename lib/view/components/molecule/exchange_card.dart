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

class ExchangeCard extends StatelessWidget {
  const ExchangeCard({super.key, required this.exchangeData, this.exchange, required this.isJunior});

  final Exchange exchangeData;
  final bool isJunior;
  final void Function(Exchange)? exchange;

  @override
  Widget build(BuildContext context) {
    return ListItem(
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
            ])));
  }
}
