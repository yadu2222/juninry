import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
// view
import '../../components/template/scroll_template.dart';
import '../../components/organism/latest_notice_tab.dart';
import '../../components/organism/shortcuts.dart' as setList;
import '../../components/organism/homework_tab.dart';
// api
import '../../../apis/controller/homework_req.dart';
import '../../../constant/sample_data.dart'; // sampleData
// model
import '../../../models/homework_model.dart';

class PageHome extends HookWidget {
  final bool isTeacher;
  const PageHome.junior({super.key,this.isTeacher = false});
  const PageHome.teacher({super.key,this.isTeacher = true});

  final String title = 'ホーム';
  @override
  Widget build(BuildContext context) {
    HomeworkReq homeworkReq = HomeworkReq(context: context); // 通信用クラスのインスタンスを生成
    final homeworkData = useState<List<Homework>>([]); // データを格納するための変数

    // 初回のみ実行
    // ここでapiから課題のリストを取得
    useEffect(() {
      // 非同期処理を実行するための関数
      Future<void> fetchData() async {
        debugPrint('課題を取得するよ');
        final data = await homeworkReq.getHomeScreenHomeworkHandler();
        debugPrint(data.toString());
        // 空でない場合のみデータをセット
        // えらーがでるからね、、
        if (data.isNotEmpty) {
          List<Homework> homeworkList = data.cast<Homework>(); // キャスト
          homeworkData.value = homeworkList;
        }
      }

      fetchData(); // 非同期処理を実行
      return () {};
    }, []);

    return ScrollTemplate(
        title: title,

        // クラス追加+登録のページに遷移
        featureIconButton: IconButton(
          onPressed: () {
            context.go('/home/class');
          },
          iconSize: 35,
          icon: const Icon(Icons.supervisor_account),
        ),
        children: [
          LatestNoticeTab(noticeData: SampleData.noticesData), // 最新のお知らせタブ
          HomeworkTab(homeworkData: homeworkData.value), // 明日提出の課題タブ
          isTeacher ? setList.Shortcuts.teacher() : setList.Shortcuts.junior(), // ショートカットセット
        ]);
  }
}
