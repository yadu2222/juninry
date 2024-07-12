import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
// view
import '../../components/template/basic_template.dart';
import '../../components/organism/homework_list.dart';
import '../../components/molecule/progress_bar.dart';
// api
import '../../../apis/controller/homework_req.dart';

class PageHomeworkJunior extends HookWidget {
  const PageHomeworkJunior({super.key});

  final String title = '課題一覧'; // appbarのタイトル
  final double progress = 0.2; // 進捗率

  @override
  Widget build(BuildContext context) {
    HomeworkReq homeworkReq = HomeworkReq(context: context); // 通信用クラスのインスタンスを生成
    final homeworkData = useState<List<dynamic>>([]); // データを格納するための変数

    // 初回のみ実行
    // ここでapiから課題のリストを取得
    useEffect(() {
      // 非同期処理を実行するための関数
      Future<void> fetchData() async {
        debugPrint('課題を取得するよ');
        final data = await homeworkReq.getHomeworksHandler();
        debugPrint(data.toString());
        homeworkData.value = data;
      }

      fetchData(); // 非同期処理を実行
      return () {};
    }, []);

    return BasicTemplate(title: title, children: [
      ProgressBar(progress: progress), // 進捗バー
      Expanded(child: HomeworkList.limit(homeworkData: homeworkData.value)), // 課題リスト
    ]);
  }
}