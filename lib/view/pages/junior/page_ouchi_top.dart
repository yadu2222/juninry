import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
// view
import '../../components/template/basic_template.dart';
import '../../components/organism/help_list.dart';
import '../../components/organism/ouchi_shortcuts.dart';
import '../../components/molecule/reward_point.dart';
import '../../components/molecule/divider.dart';
import '../../components/atoms/alert_dialog.dart';
// api
import '../../../apis/controller/help_req.dart';
import '../../../apis/controller/user_req.dart';
// model
import '../../../models/help_model.dart';
import '../../../models/user_model.dart';

class PageOuchiTopJunior extends HookWidget {
  PageOuchiTopJunior({super.key});

  final String title = 'おうち';

  @override
  Widget build(BuildContext context) {
    HelpReq helpReq = HelpReq(context: context);
    UserReq userReq = UserReq(context: context);

    final ouchiPoint = useState<int>(0); // データを格納するための変数
    final helpData = useState<List<Help>>([]); // データを格納するための変数


    // おてつだい消化処理
    void helpdiDestion(Help help) async {
      // 保護者に確認を取るべきでは？ とらなくていいらしいです
      help.isReword = false;
      helpData.value = List.from(helpData.value);
      // APIへ加算申請とポイントの更新
      await helpReq.destionHelpHandler(help).then((value) => ouchiPoint.value = value!);
    }

    // 本当にできたのか？と確認し、消化処理に投げる
    void destionCheck(Help help) {
      AlertDialogUtil.show(
        context: context,
        title: 'おてつだい完了',
        content: '本当におてつだいを完了しましたか？',
        positiveAction: (
          'はい',
          () {
            helpdiDestion(help);
          }
        ),
        negativeAction: ('いいえ', () {}),
      );
    }

    // おてつだいの取得
    void getHelps() async {
      helpData.value = await helpReq.getHelpsHandler();
      // helpData.value = SampleData.helpData;
    }

    useEffect(() {
      // ポイントの取得
      void getOuchiPoint() async {
        User user = await userReq.getUserHandler();
        ouchiPoint.value = user.ouchiPoint!;
      }

      getOuchiPoint(); // ポイントの取得
      // 児童かを判別
      getHelps(); // おてつだいの取得
      return () {};
    }, []);

    void movePointHistory() {}
    return BasicTemplate(title: title, children: [
      // ここにおうちのコンテンツを追加
      // たまっているポイント
      ReweadPoint(rewards: ouchiPoint.value, onTap: movePointHistory),
      // 交換所あるよという主張
      const OuchiShortCuts(),
      const DividerView(
        icon: Icons.flag,
        title: 'おてつだい',
      ),
      // おてつだい一覧(デイリーミッションなかんじ)
      Expanded(child: Helplist(helps: helpData.value, reward: destionCheck))
    ]);
  }
}
