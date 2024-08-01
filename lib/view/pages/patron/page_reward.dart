import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:juninry/view/components/template/basic_template.dart';
// view
import '../../components/organism/reward_list.dart';
import '../../components/atoms/add_button.dart';
// model
import '../../../models/reward_model.dart';
// api
import '../../../apis/controller/reward_req.dart';

class PageRewardPatron extends HookWidget {
  const PageRewardPatron({super.key});

  final String title = 'ごほうび';
  @override
  Widget build(BuildContext context) {
    RewardReq rewardReq = RewardReq(context: context);
    final rewardData = useState<List<Reward>>([]); // GOHOUBIデータ

    // GOHOUBI取得
    Future<void> getRewards() async {
      rewardData.value = await rewardReq.getRewardsHandler();
      // helpData.value = SampleData.helpData;
    }

    // ごほうび登録処理
    void addReward() {
      // 登録画面に遷移
      context.push('/ouchi/top/reward/register').then((_) => getRewards());
    }

    useEffect(() {
      getRewards();
      return () {};
    }, []);

    // ポイントの取引履歴に遷移？
    void reward() {}

    return Stack(children: [
      BasicTemplate(title: title, children: [
        // ごほうびリスト
        Expanded(
            child: rewardData.value.isEmpty
                ? const Center(child: Text('ごほうびを登録しましょう！'))
                : RefreshIndicator(
                    onRefresh: () async {
                      await getRewards();
                    },
                    child: RewardList(
                      isJunior: false,
                      rewards: rewardData.value,
                      rewardPoint: 0,
                    )))
      ]),
      Positioned(bottom: 25, right: 25, child: AddButton(onPressed: addReward)), // 追加ボタン
    ]);
  }
}
