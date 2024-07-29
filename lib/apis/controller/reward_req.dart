import 'package:flutter/material.dart';

import '../service/reward_service.dart';

// import 'package:go_router/go_router.dart';
import '../../view/components/atoms/toast.dart';
import '../../../constant/messages.dart';
import '../../models/reward_model.dart';
// import '../../view/components/atoms/dialog.dart';
// import '../error.dart';

class RewardReq {
  final BuildContext context;
  RewardReq({required this.context});

  // ごほうび取得
  Future<List<Reward>> getRewardsHandler() async {
    try {
      return await RewardService.getReward();
    } catch (error) {
      ToastUtil.show(message: "おわんないよ〜〜");
      return [];
    }
  }

  // ごほうび交換
  Future<int?> ExchangeRewardHandler(Reward reward) async {
    try {
      int result = await RewardService.exchangeReward(reward);
      ToastUtil.show(message: Messages.exchangeSuccess); // 報告に成功
      return result;
    } catch (error) {
      ToastUtil.show(message: Messages.exchangeError);
      return null;
    }
  }

  // GOHOUBI登録
  Future<void> registerRewardHandler(Reward reward) async {
    try {
      await RewardService.registerReward(reward);
      ToastUtil.show(message: Messages.registerSuccess); // 登録に成功
    } catch (error) {
      ToastUtil.show(message: Messages.registerError);
    }
  }

}
