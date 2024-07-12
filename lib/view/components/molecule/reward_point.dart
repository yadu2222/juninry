import 'package:flutter/material.dart';
// view
import '../atoms/listitem.dart';
// constant
// import '../../../constant/colors.dart';
import '../../../constant/fonts.dart';
// model
// import '../../../models/reward_model.dart';

// 保有ポイントの表示
class ReweadPoint extends StatelessWidget {
  final int rewards; // 保有ポイント
  final void Function() onTap; // 履歴に遷移したいなあ

  const ReweadPoint({
    super.key,
    required this.rewards,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListItem(
      widget: Column(
        children: [
          const Text('保有ポイント', style: Fonts.h4),
          Text('${rewards.toString()} P', style: Fonts.h1),
        ],
      ),
    );
  }
}
