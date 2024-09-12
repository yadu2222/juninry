import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:juninry/models/homework_model.dart';
// view
import '../../components/template/basic_template.dart';
import '../../components/organism/homework_list.dart';
import '../../components/molecule/progress_bar.dart';
import '../../components/molecule/no_resourcs.dart';
import '../../components/atoms/add_button.dart';
// api
import '../../../apis/controller/homework_req.dart';
import '../../../router/router.dart';

class PageHomework extends HookWidget {
  const PageHomework({super.key, this.near = false});
  const PageHomework.near({super.key, this.near = true});

  final bool near;
  final String title = '課題'; // appbarのタイトル
  final double progress = 0.2; // 進捗率

  @override
  Widget build(BuildContext context) {
    HomeworkReq homeworkReq = HomeworkReq(context: context); // 通信用クラスのインスタンスを生成
    final homeworkData = useState<List<dynamic>>([]); // データを格納するための変数
    final branchType = useState<List<StatefulShellBranch>>([]);

    // 追加ボタン押下時の処理
    void addPressed() {
      // 遷移処理
      context.go('/homework/register');
    }

    // homworkカードを押下した際の処理
    void cardPressed(Homework homework) async {
      // 児童のときは遷移
      if (await isBranch(BranchType.junior)) {
        context.go('/homework/submittion', extra: {'homeworkId': homework.homeworkUUID,'homework':homework}); 

        // ほごしゃ
      } else if (await isBranch(BranchType.junior)) {
        // 未提出
        if (homework.submitFlg == 0) {
          // TODO:ここで提出の催促
          // 提出済
        } else {
          context.go('/homework/submittion', extra: {'homeworkId': homework.homeworkUUID});
        }
        // 教員
      } else {
        // // 画面遷移
        context.push('/homework/submittions/',
            // 選択した宿題のUUIDを遷移先に渡す
            extra: {'homeworkUUID': homework.homeworkUUID});
      }
    }

    // 課題を取得
    Future<void> getHomework() async {
      if (near) {
        final data = await homeworkReq.getNextdayHomeworksHandler();
        homeworkData.value = data;
      } else {
        final data = await homeworkReq.getHomeworksHandler();
        homeworkData.value = data;
      }
    }

    Future<void> getBranch() async {
      branchType.value = await getBranches();
    }

    // 初回のみ実行
    // ここでapiから課題のリストを取得
    useEffect(() {
      // 非同期処理を実行するための関数
      getHomework();
      getBranch();
      return () {};
    }, []);

    return Stack(children: [
      BasicTemplate(title: title, children: [
        if (!(branchType.value == BranchType.teacher.branch)) (homeworkData.value.isEmpty ? const SizedBox.shrink() : ProgressBar(progress: progress)), // 教員以外には進捗バーの表示
        homeworkData.value.isEmpty
            ? const NoResources()
            : Expanded(
                // スクロールで再取得
                child: RefreshIndicator(
                    onRefresh: () async {
                      await getHomework();
                    },
                    child: near
                        ? HomeworkList.classes(
                            homeworkData: homeworkData.value,
                            cardPressed: cardPressed,
                            branchType: branchType.value,
                          )
                        : HomeworkList.limit(
                            homeworkData: homeworkData.value,
                            cardPressed: cardPressed,
                            branchType: branchType.value,
                          ))), // 課題リスト
      ]),
      if (branchType.value == BranchType.teacher.branch) Positioned(bottom: 25, right: 25, child: AddButton(onPressed: addPressed)), // 教員なら追加ボタンを表示
    ]);
  }
}
