import 'package:flutter/material.dart';
import '../atoms/listItem_box.dart';
import '../../../models/help_model.dart';
import '../molecule/help_card.dart';

// おてつだいリスト
class Helplist extends StatelessWidget {
  final List<Help> helps; // お手伝いリスト
  final void Function(Help) reward; // お手伝い消化処理

  const Helplist({
    super.key,
    required this.helps,
    required this.reward,
  });

  @override
  Widget build(BuildContext context) {
    return ListItemBox<Help>(
      itemDatas: helps,
      listItem: (helpData) => HelpCard(helpData: helpData, onTap: reward),
    );
  }
}
