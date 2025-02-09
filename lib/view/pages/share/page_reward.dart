import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:juninry/constant/colors.dart';
import 'package:juninry/constant/fonts.dart';
import 'package:juninry/models/reward_detail.dart';
import 'package:juninry/models/treasure_model.dart';
import 'package:juninry/view/components/atoms/add_button.dart';
import 'package:juninry/view/components/atoms/basic_button.dart';
import 'package:juninry/view/components/molecule/refresh_list.dart';
import 'package:juninry/view/components/organism/treasure_list.dart';
import 'package:numberpicker/numberpicker.dart';
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
    final treasureData = useState<List<Treasure>>([]); // 宝箱のデータを格納するための変数

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

    // addButton
    void add() {
      if (!isJunior.value) {
        // rewardを選択している場合
        if (isSelected.value) {
          addReward();
          // treasureを選択している場合
        } else {
          context.push('/ouchi/top/reward/treasure').then((_) => getRewards());
        }
      }
    }

    // 宝箱を取得
    Future<void> getTreasure() async {
      // 宝箱を取得
      treasureData.value = await rewardReq.getTreasuresHandler();
    }

    // タブを切り替え
    void changeTab() {
      isSelected.value = !isSelected.value;

      if (isSelected.value) {
        getRewards();
      } else {
        getTreasure();
      }
    }

    // 宝箱にポイントを貯める通信を行う
    Future<void> chargePoint(Treasure treasure, int point) async {
      int pointResult =
          await rewardReq.addPointBoxHandler(treasure.boxUuid, point);

      if (pointResult != 0) {
        // ポイントを更新
        treasure.totalPoint = pointResult;
        ouchiPoint.value -= point;
      }
    }

    // 宝箱のロック操作
    Future<void> toggleBoxLock(Treasure treasure) async {
      treasure.isOpen = await rewardReq.toggleBoxLockHandler(treasure);
    }

    // 宝箱にポイントを貯める処理
    void charge(Treasure treasure) {
      // 宝箱にものが入っていない場合
      //TODO: 宝箱の中身を設定するページに遷移

      if (isJunior.value &&
          treasure.reward!.rewardPoint - treasure.totalPoint! < 1) {
        // TODO：宝箱をあけるページに遷移
        context.go('/ouchi/top/reward/treasure', extra: {'treasure': treasure});
        return;
      }
      // HACK: ポイントの初期値を指定
      int maxValue = 1;
      if (treasure.reward != null) {
        maxValue = treasure.reward!.rewardPoint - treasure.totalPoint!;
      }
      showDialog(
          context: context,
          barrierDismissible: true,
          builder: (BuildContext context) {
            int addPoint = 1;
            // useStateを使えないのでstatefulで対応
            return StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
              void changePoint(int value) {
                setState(() {
                  addPoint = value;
                });
              }

              return AlertDialog(
                elevation: 0.0, // ダイアログの影を削除
                backgroundColor: Colors.transparent, // 背景色
                content: Container(
                    width: 500,
                    decoration: BoxDecoration(
                      color: AppColors.iconLight,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        RewardDetail(
                          rewardData: treasure.reward,
                        ),
                        isJunior.value && ouchiPoint.value > 0
                            ? Column(children: [
                                const Text("何ポイント貯めますか？", style: Fonts.h5),
                                NumberPicker(
                                    minValue: 1,
                                    maxValue: maxValue > ouchiPoint.value
                                        ? ouchiPoint.value
                                        : maxValue,
                                    value: addPoint,
                                    onChanged: (value) =>
                                        setState(() => changePoint(value))),
                                BasicButton(
                                  isColor: true,
                                  text: "確定",
                                  onPressed: () {
                                    chargePoint(
                                        treasure, addPoint); // ポイントを貯める処理
                                    Navigator.pop(context); // ダイアログを閉じる
                                  },
                                )
                              ])
                            : const SizedBox(),
                        !isJunior.value
                            ? treasure.reward != null
                                // 宝箱がロックされているならばロックを解除するボタンを表示
                                ? treasure.isOpen == 1 || treasure.isOpen == 2
                                    ? BasicButton(
                                        isColor: true,
                                        text: 'ロック解除',
                                        onPressed: () {
                                          Navigator.pop(context);
                                          toggleBoxLock(treasure);
                                        })
                                    : BasicButton(
                                        isColor: false,
                                        text: 'ロック',
                                        onPressed: () {
                                          Navigator.pop(context);
                                          toggleBoxLock(treasure);
                                        },
                                      )
                                : BasicButton(
                                    isColor: true,
                                    text: 'ご褒美を登録',
                                    onPressed: () {
                                      // まずダイアログを閉じる
                                      Navigator.pop(context);
                                      context.go(
                                        '/ouchi/top/reward/treasureRegister',
                                        extra: {
                                          'treasure': {
                                            'boxUuid': treasure.boxUuid,
                                            'rewardPoint':
                                                treasure.reward?.rewardPoint,
                                            'rewardName':
                                                treasure.reward?.rewardName,
                                            'note': treasure.reward?.note,
                                            'iconId': treasure.reward?.iconId
                                          }
                                        },
                                      );
                                    },
                                  )
                            : const SizedBox()
                      ],
                    )),
              );
            });
          });
      // }
    }

    useEffect(() {
      // ポイントの取得
      void getOuchiPoint() async {
        User user = await userReq.getUserHandler();
        ouchiPoint.value = user.ouchiPoint!;
      }

      getOuchiPoint();
      getRewards();
      getTreasure();
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
            IndexTab(
                onTap: changeTab,
                icon: Icons.auto_awesome,
                isSelected: isSelected.value,
                margin: const EdgeInsets.only(right: 5)),
            IndexTab(
              onTap: changeTab,
              icon: Icons.redeem,
              isSelected: !isSelected.value,
            ),
          ],
        ),
        // 表示するリスト
        Expanded(
            // isSelectの状態に合わせて表示を変更
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
                : RefreshList(
                    itemDatas: rewardData.value,
                    list: TreasureList(
                        treasures: treasureData.value, charge: charge),
                    text: "たからばこ",
                    refresh: getTreasure))
      ]),

      isJunior.value
          ? const SizedBox.shrink()
          : Positioned(
              bottom: 25,
              right: 25,
              child: AddButton(onPressed: add)) // 追加ボタン]);
    ]);
  }
}
