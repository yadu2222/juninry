import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:juninry/constant/sample_data.dart';
import 'package:juninry/view/components/atoms/dialog.dart';
import '../../components/template/basic_template.dart';

import '../../components/organism/homework_register_tab.dart';
import '../../components/molecule/divider.dart';
import '../../components/organism/register_homework_list.dart';
import '../../../models/teaching_item_model.dart';
import '../../components/atoms/basic_button.dart';

import '../../../constant/messages.dart';
import '../../../models/register_homework_model.dart';
import '../../components/atoms/toast.dart';

class PageHomeworkRegisterTeacher extends HookWidget {
  // タイトル
  final String title = '課題登録';
  // 右上に表示するアイコン
  final Icon featureIconButton = const Icon(
    Icons.drive_file_rename_outline_rounded,
    size: 30,
  );
  const PageHomeworkRegisterTeacher({super.key, this.selectDate});
  final String? selectDate; // routeがエラーを吐くのでStringで受け取る

  @override
  Widget build(BuildContext context) {
    // 教材リスト
    final teachingMaterialData = useState<List<TeachingItem>>([]);
    final selectDateHook = useState<String?>(selectDate);
    // 選択中の課題データ
    final registerHomeworkData = useState<List<RegisterHomework>>([]); // 空で初期化
    // 読み込んだ課題データ
    final registerHomeworkDataOld = useState<List<RegisterHomework>>([]); // 空で初期化

    // indexを受け取って配列に追加
    void add(int index) {
      // TODO:日付
      // TODO:クラスUUID
      final newHomework = RegisterHomework(homeworkLimit: DateTime.now(), classUUID: "aaa", teachingItem: teachingMaterialData.value[index]); // 追加したいオブジェクト
      registerHomeworkData.value = List.from(registerHomeworkData.value)..add(newHomework); // 追加
    }

    // indexを受け取って配列から削除
    // あくまで表示上の削除であり、下書きに保存のタイミングで変更をかける
    void deleteRgisterHomework(int index) {
      // RegisterHomework.deleteHomeworkDrafts(registerHomeworkData.value[index]); // dbから削除
      registerHomeworkData.value = List.from(registerHomeworkData.value)..removeAt(index); // 削除
    }

    // 登録処理
    void register() async {
      // 元の配列と現在の配列を比較して変更があればDBに投げる
      // 古いものを全削除
      for (var homework in registerHomeworkDataOld.value) {
        RegisterHomework.deleteHomeworkDrafts(homework);
      }
      bool isRegister = await RegisterHomework.registerHomeworkDrafts(registerHomeworkData.value);
      if (isRegister) {
        // 保存に成功したよ
        ToastUtil.show(message: Messages.draftRegisterSuccess);
        context.push('/homework'); // 課題一覧に遷移
      } else {
        // 失敗エラー
        ToastUtil.show(message: Messages.databaseErrorMsg);
      }
    }

    bool oldCheck() {
      if (registerHomeworkDataOld.value != registerHomeworkData.value) {
        // 変更がある場合
        // 保存を促す
        DialogUtil.show(
            context: context,
            child: Row(
              children: [Text('保存する？')],
            ));
        return true;
      } else {
        return false;
      }
    
    }

    // 初回のみ実行
    // ここでapiから教材リストを取得
    useEffect(() {
      Future<void> fetchData() async {
        if (selectDate != null) {
          debugPrint('しゅとくしゅとくしゅとく');
          final data = await RegisterHomework.getHomeworkDraftsForDate(DateTime.parse(selectDateHook.value!));
          debugPrint(data.toString());
          registerHomeworkDataOld.value = data;
          registerHomeworkData.value = registerHomeworkDataOld.value;
        }
      }

      fetchData();
      teachingMaterialData.value = SampleData.teachingItemData;
      return () {};
    }, [selectDateHook]);

    return BasicTemplate(
        title: title,
        // 変更があれば保存を促す
        popFunction: oldCheck,
        // 下書き一覧に遷移
        featureIconButton: IconButton(
            onPressed: () {
              GoRouter.of(context).go('/homework/register/drafts');
            },
            icon: featureIconButton),
        children: [
          // ここに課題登録フォームを追加
          HomeworkRegisterTab(
            teachingItemData: SampleData.teachingItemData,
            onTap: add,
          ),
          // 区切り線
          const DividerView(
            indent: 15,
            endIndent: 15,
            dividWeight: 2,
          ),
          // 登録中の課題リスト
          Expanded(
              child: RegisterHomeworkList(
            onTap: deleteRgisterHomework,
            registerHomeworkData: registerHomeworkData.value,
          )),

          // ボタン
          Row(
              mainAxisAlignment: MainAxisAlignment.center, // 真ん中寄せ
              children: [
                BasicButton(
                  width: 0.37,
                  text: '下書きに保存',
                  onPressed: register,
                  isColor: true,
                ),
                const SizedBox(width: 60),
                BasicButton(
                  icon: Icons.check,
                  text: '登録',
                  width: 0.37,
                  onPressed: () {
                    // TODO:APIに登録処理を投げる
                  },
                  isColor: false,
                ),
              ])
        ]);
  }
}
