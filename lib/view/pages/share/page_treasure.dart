import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:juninry/models/treasure_model.dart';
import 'package:juninry/view/components/organism/treasure_list.dart';
import '../../../router/router.dart';
// view
import '../../components/template/basic_template.dart';
// api


class PageTreasure extends HookWidget {
  const PageTreasure({super.key, this.near = false});
  const PageTreasure.near({super.key, this.near = true});

  final bool near;
  final String title = 'たからばこ'; // appbarのタイトル

  @override
  Widget build(BuildContext context) {
    final treasureData = useState<List<Treasure>>(Treasure.testTresure); // データを格納するための変数
    final branchType = useState<List<StatefulShellBranch>>([]);

    // 宝箱の追加ページ
    void addPressed() {
      // 遷移処理
      context.go('/homework/register');
    }

    void buy(Treasure treasure) {
      // 遷移処理
      context.go('/homework/register');
    }

    // 宝箱を取得
    // Future<void> getHomework() async {
    //   if (near) {
    //     final data = await homeworkReq.getNextdayHomeworksHandler();
    //     homeworkData.value = data;
    //   } else {
    //     final data = await homeworkReq.getHomeworksHandler();
    //     homeworkData.value = data;
    //   }
    // }

    Future<void> getBranch() async {
      branchType.value = await getBranches();
    }

    // 初回のみ実行
    // ここでapiから課題のリストを取得
    useEffect(() {
      // 非同期処理を実行するための関数
      getBranch();
      return () {};
    }, []);

    return BasicTemplate(title: title, featureIconButton: IconButton(onPressed: addPressed, icon: Icon(Icons.add)), children: [Expanded(child: TreasureList(treasures: treasureData.value, buy: buy))]);
  }
}
