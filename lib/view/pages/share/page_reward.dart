import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../../../router/router.dart';
// view
import '../../components/template/scroll_template.dart';
import '../../components/molecule/reward_point.dart';
import '../../components/organism/reward_list.dart';
import '../../components/atoms/toast.dart';
import '../../components/atoms/alert_dialog.dart';
// model
import '../../../models/reward_model.dart';
import '../../../models/user_model.dart';

// api
import '../../../apis/controller/reward_req.dart';
import '../../../apis/controller/user_req.dart';
// sample
import '../../../constant/messages.dart';
import '../../../constant/sample_data.dart';

class PageReward extends HookWidget {
  const PageReward({super.key});

  final String title = 'ごほうび';
  @override
  Widget build(BuildContext context) {
    RewardReq rewardReq = RewardReq(context: context);
    UserReq userReq = UserReq(context: context);

    final isJunior = useState<bool>(false); // 児童かどうか
    final ouchiPoint = useState<int>(0); // ouchipoint
    final rewardData = useState<List<Reward>>(SampleData.rewardData); // GOHOUBIデータ

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

    // GOHOUBI取得
    // おてつだいの取得
    void getHelps() async {
      rewardData.value = await rewardReq.getRewardsHandler();
      // helpData.value = SampleData.helpData;
    }

    useEffect(() {
      // ポイントの取得
      void getOuchiPoint() async {
        User user = await userReq.getUserHandler();
        ouchiPoint.value = user.ouchiPoint!;
      }

      getOuchiPoint();
      getHelps();
      // 児童かを判別
      isBranch(BranchType.junior).then((value) => isJunior.value = value);
      return () {};
    }, []);

    // ポイントの取引履歴に遷移？
    void reward() {}

    return ScrollTemplate(title: title, children: [
      // ここにおうちのコンテンツを追加
      // たまっているポイント
      ReweadPoint(rewards: ouchiPoint.value, onTap: reward),
      // ごほうびリスト
      RewardList(
        isJunior: isJunior.value,
        rewards: rewardData.value,
        buy: exchangeCheck,
        rewardPoint: ouchiPoint.value,
      )
    ]);
  }
}
