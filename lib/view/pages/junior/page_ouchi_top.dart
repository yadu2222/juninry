import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

// view
import '../../components/template/basic_template.dart';
import '../../components/organism/help_list.dart';
import '../../components/organism/ouchi_shortcuts.dart';
import '../../components/molecule/reward_point.dart';
import '../../components/molecule/divider.dart';

// model
import '../../../models/help_model.dart';
// sample
import '../../../constant/sample_data.dart';

class PageOuchiTopJunior extends HookWidget {
  PageOuchiTopJunior({super.key});

  final String title = 'おうち';

  @override
  Widget build(BuildContext context) {
    final rewards = useState<int>(10); // データを格納するための変数
    final helpData = useState<List<Help>>(SampleData.helpData); // データを格納するための変数
    void reward(Help help) {
      // おてつだい消化処理
      // 保護者に確認を取るべきでは？ とらなくていいらしいです
      help.isReword = false;
      helpData.value = List.from(helpData.value);
      // APIへ加算申請
    }

    void movePointHistory() {}
    return BasicTemplate(title: title, children: [
      // ここにおうちのコンテンツを追加
      // たまっているポイント
      ReweadPoint(rewards: rewards.value, onTap: movePointHistory),
      // 交換所あるよという主張
      const OuchiShortCuts(),
      const DividerView(
        icon: Icons.flag,
        title: 'おてつだい',
      ),
      // おてつだい一覧(デイリーミッションなかんじ)
      Expanded(child: Helplist(helps: helpData.value, reward: reward))
    ]);
  }
}
