import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
// view
import '../../components/template/basic_template.dart';
import '../../components/organism/homework_list.dart';
import '../../components/molecule/next_day_task.dart';
// api
import '../../../apis/controller/homework_req.dart';

// TODO:api処理
class PageNextDayTaskJunior extends HookWidget {
 
  final String title = '提出';
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
        final data = await homeworkReq.getNextdayHomeworksHandler();
        debugPrint(data.toString());
        homeworkData.value = data;
      }

      fetchData(); // 非同期処理を実行
      return () {};
    }, []);

    return BasicTemplate(title: title, children: [
      const NextDayTask(),
      Expanded(child: HomeworkList.classes(homeworkData: homeworkData.value)),
    ]);
  }
}
