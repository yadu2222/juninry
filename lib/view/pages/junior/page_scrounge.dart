import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

// view
import '../../components/template/scroll_template.dart';
import '../../components/organism/reward_list.dart';
import '../../components/atoms/toast.dart';
// model
import '../../../models/reward_model.dart';
// sample
import '../../../constant/messages.dart';
import '../../../constant/sample_data.dart';


// ぺーじこぴぺしただけ
class PageScroungeJunior extends HookWidget {
  const PageScroungeJunior({super.key});

  final String title = 'おねだり';
  @override
  Widget build(BuildContext context) {
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

    return ScrollTemplate(title: title, children: [
      // 現在おねだり中のごほうびリスト
      // TODO:日付・
      RewardList(
        rewards: rewardData.value,
        buy: buy,
        rewardPoint: rewardPoint.value,
      )
    ]);
  }
}
