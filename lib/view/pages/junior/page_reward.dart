import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../../../router/router.dart';
// view
import '../../components/template/scroll_template.dart';
import '../../components/molecule/reward_point.dart';
import '../../components/organism/reward_list.dart';
import '../../components/atoms/toast.dart';
// model
import '../../../models/reward_model.dart';
// sample
import '../../../constant/messages.dart';
import '../../../constant/sample_data.dart';

class PageRewardJunior extends HookWidget {
  const PageRewardJunior({super.key});

  final String title = 'ごほうび';
  @override
  Widget build(BuildContext context) {
    final isJunior = useState<bool>(false); // 児童かどうか
    final rewardPoint = useState<int>(10); // データを格納するための変数
    final rewardData = useState<List<Reward>>(SampleData.rewardData); // データを格納するための変数
    void buy(Reward reward) {
      if (rewardPoint.value >= reward.rewardPoint) {
        // 購入処理
        // APIへ加算申請
      } else {
        // ポイントが足りないよ〜〜〜
        ToastUtil.show(message: Messages.pointShortage);
      }
    }

    useEffect(() {
      // 児童かを判別
      isBranch(BranchType.junior).then((value) => isJunior.value = value);
      return () {};
    }, []);

    // ポイントの取引履歴に遷移？
    void reward() {}

    return ScrollTemplate(title: title, children: [
      // ここにおうちのコンテンツを追加
      // たまっているポイント
      ReweadPoint(rewards: rewardPoint.value, onTap: reward),
      // ごほうびリスト
      RewardList(
        isJunior: isJunior.value,
        rewards: rewardData.value,
        buy: buy,
        rewardPoint: rewardPoint.value,
      )
    ]);
  }
}
