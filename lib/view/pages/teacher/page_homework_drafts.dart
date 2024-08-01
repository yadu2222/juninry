import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../../components/template/basic_template.dart';

import '../../components/organism/homework_draft_list.dart';
import '../../../models/register_homework_model.dart';
import '../../components/atoms/alert_dialog.dart';
import '../../../constant/messages.dart';

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
    final draftData = useState<List<List<RegisterHomework>>>([]);
    // dbから下書きデータを取得
    Future<void> getDrafts() async {
      final data = await RegisterHomework.getHomeworkDraftsList();
      draftData.value = data;
    }

    // 下書き削除
    void delete(List<RegisterHomework> homeworks) async {
      for (var homework in homeworks) {
        RegisterHomework.deleteHomeworkDrafts(homework);
      }
      await getDrafts(); // 削除後に再取得
    }

    // 削除確認ダイアログ
    void deleteCheck(List<RegisterHomework> homeworks) {
      // 変更がある場合
      // 保存を促す
      AlertDialogUtil.show(
        context: context,
        content: Messages.draftDelete,
        negativeAction: ("いいえ", () {}),
        positiveAction: (
          "削除する",
          () async {
            delete(homeworks);
          }
        ),
      );
    }

    // TODO:読み込みのタイミングがなんか変
    // useEffect内で非同期処理を実行するための方法
    useEffect(() {
      // 直接非同期関数を書くことはできない
      getDrafts(); // 非同期関数を呼び出し
      return () {};
    }, []);

    return BasicTemplate(title: title, children: [
      // 下書き一覧
      Expanded(
        child: HomeworkDraftList(homeworkData: draftData.value, delete: deleteCheck, get: getDrafts),
      )
    ]);
  }
}
