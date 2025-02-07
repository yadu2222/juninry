import 'package:flutter/material.dart';
import 'package:juninry/models/treasure_model.dart';

import '../service/reward_service.dart';

// import 'package:go_router/go_router.dart';
import '../../view/components/atoms/toast.dart';
import '../../../constant/messages.dart';
import '../../models/reward_model.dart';
import '../../models/exchange_model.dart';
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

  // 交換されたごほうびを取得
  Future<List<Exchange>> getExchangesHandler() async {
    try {
      return await RewardService.getExchange();
    } catch (error) {
      ToastUtil.show(message: "おわんないよ〜〜");
      return [];
    }
  }

  // 交換されたごほうびを消化
  Future<void> digestExchangeHandler(Exchange exchange) async {
    try {
      await RewardService.digestionExchange(exchange);
      ToastUtil.show(message: Messages.digestSuccess); // 消化に成功
    } catch (error) {
      ToastUtil.show(message: Messages.digestError);
    }
  }

  // 宝箱にポイントを追加
  Future<int> addPointBoxHandler(String boxUuid, int point) async {
    try {
      int pointResult = await RewardService.addPointBox(boxUuid, point);

      ToastUtil.show(message: Messages.addPointSuccess); // 登録に成功
      return pointResult;
    } catch (error) {
      ToastUtil.show(message: Messages.addPointError);
      return 0;
    }
  }

  Future<List<Treasure>> getTreasuresHandler() async {
    try {
      return await RewardService.getTreasure();

    } catch (error) {
      ToastUtil.show(message: "おわんないよ〜〜");
      return [];
    }
  }

  Future<int> toggleBoxLockHandler(Treasure treasure) async {
    try {
      return await RewardService.toggleBoxLock(treasure.boxUuid);
    } catch (error) {
      ToastUtil.show(message: "おわんないよ〜〜");
      return treasure.isOpen!;
    }
  }
}
