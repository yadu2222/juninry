import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:juninry/constant/sample_data.dart';
import '../../components/template/basic_template.dart';

import '../../components/organism/homework_draft_list.dart';
import '../../../models/homework_model.dart';

class PageHomeworkDraftsTeacher extends HookWidget {
  // タイトル
  final String title = '下書き一覧';
  // 右上に表示するアイコン
  final Icon featureIconButton = const Icon(
    Icons.drive_file_rename_outline_rounded,
    size: 30,
  );
  const PageHomeworkDraftsTeacher({super.key});

  // 下書きリスト
  // dbから取得
  @override
  Widget build(BuildContext context) {
    final draftData = useState<List<List<Homework>>>([]);

    // useEffect内で非同期処理を実行するための方法
    useEffect(() {
      
      Future<void> fetchData() async {
        final data = await Homework.getHomeworkDrafts();  // dbから下書きデータを取得
        draftData.value = data;
      }
      // 直接非同期関数を書くことはできないため、useEffect内で定義し呼び出す
      fetchData(); // 非同期関数を呼び出し
      // useEffectのクリーンアップ関数
      return () {};
    }, []); // 空の依存配列を渡して、初回のみ実行(変更を察知しない)

    return BasicTemplate(
        title: title,
        children: [
          // 下書き一覧
          HomeworkDraftList(homeworkData: draftData.value),
        ]);
  }
}
