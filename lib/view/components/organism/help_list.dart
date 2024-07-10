import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';

import '../atoms/listItem_box.dart';
import '../../../models/help_model.dart';
import '../molecule/help_card.dart';
import '../molecule/divider.dart';

class Helplist extends StatelessWidget {
  final List<Help> helps;
  final void Function(Help) onTap;

  const Helplist({
    super.key,
    required this.helps,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const DividerView(
        icon: Icons.flag,
        title: 'おてつだい',
      ),
      ListItemBox<Help>(
        itemDatas: helps,
        listItem: (helpData) => HelpCard(helpData: helpData, onTap: onTap),
      )
    ]);
  }
}
