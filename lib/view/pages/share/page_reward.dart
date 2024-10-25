import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:juninry/models/treasure_model.dart';
import 'package:juninry/view/components/atoms/add_button.dart';
import 'package:juninry/view/components/molecule/refresh_list.dart';
import 'package:juninry/view/components/organism/treasure_list.dart';
import '../../../router/router.dart';
// view
import '../../components/template/basic_template.dart';
import '../../components/molecule/reward_point.dart';
import '../../components/organism/reward_list.dart';
import '../../components/atoms/toast.dart';
import '../../components/atoms/alert_dialog.dart';
import '../../components/atoms/index_tab.dart';
// model
import '../../../models/reward_model.dart';
import '../../../models/user_model.dart';

// api
import '../../../apis/controller/reward_req.dart';
import '../../../apis/controller/user_req.dart';
// sample
import '../../../constant/messages.dart';

class PageReward extends HookWidget {
  const PageReward({super.key});

  final String title = 'ごほうび';
  @override
  Widget build(BuildContext context) {
    RewardReq rewardReq = RewardReq(context: context);
    UserReq userReq = UserReq(context: context);

    final isJunior = useState<bool>(false); // 児童かどうか
    final ouchiPoint = useState<int>(0); // ouchipoint
    final rewardData = useState<List<Reward>>([]); // GOHOUBIデータ
    final isSelected = useState<bool>(true);
    final treasureData = useState<List<Treasure>>(Treasure.testTresure); // 宝箱のデータを格納するための変数

    // ごほうび交換
    void exchange(Reward reward) {
      // 交換処理
      rewardReq.ExchangeRewardHandler(reward).then((value) {
        if (value != null) {
          // ポイントの更新
          ouchiPoint.value = value;
        }
      });
    }

    // 交換しますか？チェック
    void exchangeCheck(Reward reward) {
      // ポイントが足りているかチェック

      if (isJunior.value) {
        if (ouchiPoint.value >= reward.rewardPoint) {
          AlertDialogUtil.show(
            context: context,
            title: '交換確認',
            content: '本当に交換しますか？',
            positiveAction: (
              'はい',
              () {
                exchange(reward);
              }
            ),
            negativeAction: ('いいえ', () {}),
          );
        } else {
          // ポイントが足りないよ〜〜〜
          ToastUtil.show(message: Messages.pointShortage);
        }
      }
    }

    // GOHOUBI取得
    Future<void> getRewards() async {
      rewardData.value = await rewardReq.getRewardsHandler();
      // helpData.value = SampleData.helpData;
    }

    // ごほうび登録
    void addReward() {
      // 登録画面に遷移
      if (!isJunior.value) {
        context.push('/ouchi/top/reward/register').then((_) => getRewards());
      }
    }

    // タブを切り替え
    void changeTab() {
      debugPrint('changeTab');
      isSelected.value = !isSelected.value;
    }

    // 宝箱を取得
    Future<void> getTreasure() async {
      // 宝箱を取得
    }

    // 宝箱にポイントを貯める処理
    void charge(Treasure treasure) {
      // ポイントを貯める処理
    }

    useEffect(() {
      // ポイントの取得
      void getOuchiPoint() async {
        User user = await userReq.getUserHandler();
        ouchiPoint.value = user.ouchiPoint!;
      }

      getOuchiPoint();
      getRewards();
      // 児童かを判別
      isBranch(BranchType.junior).then((value) => isJunior.value = value);
      return () {};
    }, []);

    // ポイントの取引履歴に遷移？
    void reward() {}

    return Stack(children: [
      BasicTemplate(title: title, children: [
        // ここにおうちのコンテンツを追加
        // たまっているポイント
        ReweadPoint(rewards: ouchiPoint.value, onTap: reward),
        const SizedBox(height: 5),
        // ごほうびリストタブ
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IndexTab(onTap: changeTab, icon: Icons.auto_awesome, isSelected: isSelected.value, margin: const EdgeInsets.only(right: 5)),
            IndexTab(
              onTap: changeTab,
              icon: Icons.redeem,
              isSelected: !isSelected.value,
            ),
          ],
        ),
        // 表示するリスト
        Expanded(
            child: isSelected.value
                // ごほうびリスト
                ? RefreshList(
                    itemDatas: rewardData.value,
                    list: RewardList(
                      isJunior: isJunior.value,
                      rewards: rewardData.value,
                      buy: exchangeCheck,
                      rewardPoint: ouchiPoint.value,
                    ),
                    text: "GOHOUBI",
                    refresh: getRewards)

                // 宝箱リスト
                : RefreshList(itemDatas: rewardData.value, list: TreasureList(treasures: treasureData.value, charge: charge), text: "たからばこ", refresh: getTreasure))
      ]),

      isJunior.value ? const SizedBox.shrink() : Positioned(bottom: 25, right: 25, child: AddButton(onPressed: addReward)) // 追加ボタン]);
    ]);
  }
}
