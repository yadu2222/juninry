import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
// view
import '../../components/template/basic_template.dart';
import '../../components/organism/help_list.dart';
import '../../components/organism/ouchi_shortcuts.dart';
import '../../components/molecule/divider.dart';
// import '../../components/atoms/alert_dialog.dart';
import '../../components/atoms/add_button.dart';
// api
import '../../../apis/controller/help_req.dart';
import '../../../apis/controller/user_req.dart';
// model
import '../../../models/help_model.dart';

class PageOuchiTopPatron extends HookWidget {
  const PageOuchiTopPatron({super.key});

  final String title = 'おうち';
  @override
  Widget build(BuildContext context) {
    HelpReq helpReq = HelpReq(context: context);
    UserReq userReq = UserReq(context: context);

    final ouchiPoint = useState<int>(0); // データを格納するための変数
    final helpData = useState<List<Help>>([]); // データを格納するための変数

    // おてつだいの取得
    void getHelps() async {
      helpData.value = await helpReq.getHelpsHandler();
      // helpData.value = SampleData.helpData;
    }

    // おてつだい登録処理
    void addHelp() {
      // おてつだい登録処理
      // おてつだい登録画面に遷移
      context.push('/ouchi/top/register').then((_) => getHelps());

      // おわったら再度おてつだいの取得
    }

    useEffect(() {
      getHelps(); // おてつだいの取得
      return () {};
    }, []);

    return Stack(children: [
      BasicTemplate(title: title, children: [
        // ここにおうちのコンテンツを追加
        // 交換所あるよという主張
        const OuchiShortCuts(),
        const DividerView(
          icon: Icons.flag,
          title: 'おてつだい',
        ),
        // おてつだい一覧(デイリーミッションなかんじ)
        Expanded(child: helpData.value.isEmpty ? const Center(child: Text('おてつだいを登録しましょう！')) : Helplist(helps: helpData.value)),
      ]),
      Positioned(bottom: 25, right: 25, child: AddButton(onPressed: addHelp)), // 追加ボタン
    ]);
  }
}
