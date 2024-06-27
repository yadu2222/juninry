import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:juninry/constant/sample_data.dart';
import '../../components/template/basic_template.dart';

import '../../components/organism/homework_register_tab.dart';
import '../../components/molecule/divider.dart';
import '../../components/organism/register_homework_list.dart';
import '../../../models/teaching_item_model.dart';
import '../../components/atoms/basic_button.dart';

import '../../../models/register_homework_model.dart';

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
    // 選択中の教材データ
    final registerHomeworkData = useState<List<RegisterHomework>>([]); // 空で初期化

    // indexを受け取って配列に追加
    void register(int index) {
      // TODO:日付
      // TODO:クラスUUID
      final newHomework = RegisterHomework(homeworkLimit: DateTime.now(), classUUID: "aaa", teachingItem: teachingMaterialData.value[index]); // 追加したいオブジェクト
      registerHomeworkData.value = List.from(registerHomeworkData.value)..add(newHomework); // 追加
    }

    // indexを受け取って配列から削除
    void deleteRgisterHomework(int index) {
      RegisterHomework.deleteHomeworkDrafts(registerHomeworkData.value[index]); // dbから削除
      registerHomeworkData.value = List.from(registerHomeworkData.value)..removeAt(index); // 削除
    }

    // 初回のみ実行
    // ここでapiから教材リストを取得
    useEffect(() {
      Future<void> fetchData() async {
        if (selectDate != null) {
          debugPrint('しゅとくしゅとくしゅとく');
          final data = await RegisterHomework.getHomeworkDraftsForDate(DateTime.parse(selectDateHook.value!));
          debugPrint(data.toString());
          registerHomeworkData.value = data;
        }
      }

      fetchData();
      teachingMaterialData.value = SampleData.teachingItemData;
      return () {};
    }, [selectDateHook]);

    return BasicTemplate(
        title: title,
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
            onTap: register,
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
                  onPressed: () async {
                    await RegisterHomework.registerHomeworkDrafts(registerHomeworkData.value);
                    context.push('/homework'); // 課題一覧に遷移
                  },
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
