import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
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
    // dbから下書きデータを取得
    Future<void> getDrafts() async {
      final data = await Homework.getHomeworkDrafts(); 
      draftData.value = data;
    }
    // 下書き削除
    void delete(List<Homework> homeworks) async {
      for (var homework in homeworks) {
        Homework.deleteHomeworkDrafts(homework);
      }
      await getDrafts();
    }
    // useEffect内で非同期処理を実行するための方法
    useEffect(() {
      // 直接非同期関数を書くことはできない
      getDrafts(); // 非同期関数を呼び出し
      return () {};
    }, []); // 空の依存配列を渡して、初回のみ実行(変更を察知しない)

    return BasicTemplate(title: title, children: [
      // 下書き一覧
      HomeworkDraftList(
        homeworkData: draftData.value,
        onTap: delete,
      ),
    ]);
  }
}
