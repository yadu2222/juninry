import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

// view
import '../../components/template/scroll_template.dart';
import '../../components/organism/help_list.dart';
import '../../components/organism/ouchi_shortcuts.dart';
import '../../components/molecule/reward_point.dart';
// model
import '../../../models/help_model.dart';
// sample
import '../../../constant/sample_data.dart';

class PageRewardJunior extends HookWidget {
  const PageRewardJunior({super.key});

  final String title = 'ごほうび';
  @override
  Widget build(BuildContext context) {
    final rewards = useState<int>(10); // データを格納するための変数
    final helpData = useState<List<Help>>(SampleData.helpData); // データを格納するための変数
    void onTap(Help help) {
      // おてつだい消化処理
      // 保護者に確認を取るべきでは？
      help.isReword = true;
      helpData.value = List.from(helpData.value);
      // APIへ加算申請
    }

    void reward() {}

    return ScrollTemplate(title: title, children: [
      // ここにおうちのコンテンツを追加
      // たまっているポイント
      ReweadPoint(rewards: rewards.value, onTap: reward),
      // 交換所あるよという主張
      const OuchiShortCuts(),
      // おてつだい一覧(デイリーミッションなかんじ)
      Helplist(helps: helpData.value, onTap: onTap)
    ]);
  }
}