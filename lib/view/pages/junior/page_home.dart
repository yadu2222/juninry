import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
// view
import '../../components/template/scroll_template.dart';
import '../../components/organism/latest_notice_tab.dart';
import '../../components/organism/junior_shortcuts.dart';
import '../../components/organism/homework_tab.dart';
// api
import '../../../apis/controller/homework_req.dart';
import '../../../constant/sample_data.dart'; // sampleData
// model
import '../../../models/homework_model.dart';

class PageHomeJunior extends HookWidget {
  const PageHomeJunior({super.key});

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
          homeworkData.value = data as List<Homework>;
        }
      }

      fetchData(); // 非同期処理を実行
      return () {};
    }, []);

    return ScrollTemplate(title: title, children: [
      LatestNoticeTab(noticeData: SampleData.noticesData), // 最新のお知らせタブ
      HomeworkTab(homeworkData: homeworkData.value), // 明日提出の課題タブ
      JuniorShortcuts(), // ショートカットボタン
    ]);
  }
}
