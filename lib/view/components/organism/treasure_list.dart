import 'package:flutter/material.dart';
import 'package:juninry/models/treasure_model.dart';
import 'package:juninry/view/components/molecule/treasure_card.dart';
import '../atoms/listItem_box.dart';

// おてつだいリスト
class TreasureList extends StatelessWidget {
  final List<Treasure> treasures;
  final void Function(Treasure) buy;

  const TreasureList({
    super.key,
    required this.treasures,
    required this.buy,
  });

  @override
  Widget build(BuildContext context) {
    return ListItemBox<Treasure>(
      itemDatas: treasures,
      listItem: (treasure) => TreasureCard(treasure: treasure, buy: buy, ),
    );
  }
}
