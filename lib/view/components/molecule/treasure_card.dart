import 'package:flutter/material.dart';
import 'package:juninry/constant/colors.dart';
import 'package:juninry/view/components/atoms/total_point.dart';
// view
import '../atoms/listitem.dart';
// model
import 'package:juninry/models/treasure_model.dart';
// constant
import 'package:juninry/constant/fonts.dart';
import '../../../constant/reward_icon.dart';

class TreasureCard extends StatefulWidget {
  final Treasure treasure;

  const TreasureCard({
    super.key,
    required this.treasure,
  });

  @override
  State<TreasureCard> createState() => _TreasureCardState();
}

class _TreasureCardState extends State<TreasureCard> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int?>(
      valueListenable: widget.treasure.isOpenNotifier,
      builder: (context, isOpen, child) {
        return ListItem(
            padding: const EdgeInsets.only(left: 10, right: 10),
            widget: IntrinsicHeight(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                  Row(children: [
                    RewardIcon.getIcon(
                        widget.treasure.reward != null
                            ? isOpen == 1 || isOpen == 2
                                ? widget.treasure.reward!.iconId
                                : 11
                            : 10,
                        border: widget.treasure.reward != null
                            ? widget.treasure.totalPoint == widget.treasure.reward!.rewardPoint
                            : false,
                        mainColor: isOpen == 3
                            ? AppColors.iconGray
                            : AppColors.main),
                    const SizedBox(width: 10),
                    widget.treasure.reward != null
                        ? Text(widget.treasure.reward!.rewardName, style: Fonts.p)
                        : const Text("未設定", style: Fonts.pg),
                  ]),
                  TotalPoint(treasure: widget.treasure),
                ])));
      },
    );
  }
}