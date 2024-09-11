import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
// view
import '../../components/template/basic_template.dart';
import '../../components/organism/help_list.dart';
import '../../components/organism/ouchi_shortcuts.dart';
import '../../components/molecule/divider.dart';
import '../../components/atoms/add_button.dart';
// api
import '../../../apis/controller/help_req.dart';
// model
import '../../../models/help_model.dart';

class PageOuchiTopPatron extends HookWidget {
  const PageOuchiTopPatron({super.key});

  final String title = 'おうち';
  @override
  Widget build(BuildContext context) {
    HelpReq helpReq = HelpReq(context: context);
    final helpData = useState<List<Help>>([]); // データを格納するための変数

    // おてつだいの取得
    Future<void> getHelps() async {
      helpData.value = await helpReq.getHelpsHandler();
      // helpData.value = SampleData.helpData;
    }

    // おてつだい登録処理
    void addHelp() {
      // おてつだい登録処理
      // おてつだい登録画面に遷移
      // おわったら再度おてつだいの取得
      context.push('/ouchi/top/register').then((_) => getHelps());
    }

    useEffect(() {
      getHelps(); // おてつだいの取得
      return () {};
    }, []);

    return Stack(children: [
      BasicTemplate(title: title,
      featureIconButton: IconButton(
            icon: const Icon(Icons.info_outline, size: 35),
            onPressed: () {
              // おうちの説明ページへ遷移
              context.go('/ouchi/top/info');
            },
          ),
       children: [
        // ここにおうちのコンテンツを追加
        const OuchiShortCuts(),
        const DividerView(
          icon: Icons.flag,
          title: 'おてつだい',
        ),
        // おてつだい一覧(デイリーミッションなかんじ)
        Expanded(
            child: helpData.value.isEmpty
                ? const Center(child: Text('おてつだいを登録しましょう！'))
                // スクロールで再取得
                : RefreshIndicator(
                    onRefresh: () async {
                      await getHelps();
                    },
                    child: Helplist(helps: helpData.value))),
      ]),
      Positioned(bottom: 25, right: 25, child: AddButton(onPressed: addHelp)), // 追加ボタン
    ]);
  }
}
