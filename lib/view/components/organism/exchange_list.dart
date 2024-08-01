import 'package:flutter/material.dart';
import 'package:juninry/models/exchange_model.dart';
import '../atoms/listItem_box.dart';
import '../molecule/exchange_card.dart';

// おてつだいリスト
class ExchangeList extends StatelessWidget {
  final bool isJunior;
  final List<Exchange> exhanges;
  final void Function(Exchange)? exchangeDigestion;

  const ExchangeList({
    super.key,
    required this.isJunior,
    required this.exhanges,
    this.exchangeDigestion,
  });

  @override
  Widget build(BuildContext context) {
    return ListItemBox<Exchange>(
      itemDatas: exhanges,
      listItem: (exchange) => ExchangeCard(exchangeData: exchange, exchange: exchangeDigestion, isJunior: isJunior),
    );
  }
}
