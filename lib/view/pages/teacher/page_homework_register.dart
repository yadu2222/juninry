import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:juninry/constant/sample_data.dart';
import '../../components/template/basic_template.dart';
// import '../../components/organism/homework_register_form.dart';
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
  const PageHomeworkRegisterTeacher({super.key});

  // タグを選択で課題追加リストがでるようにしたい
  @override
  Widget build(BuildContext context) {
    // 教材リスト
    final teachingMaterialData = useState<List<TeachingItem>>([]);
    // 初回のみ実行
    // ここでapiから教材リストを取得
    useEffect(() {
      teachingMaterialData.value = SampleData.teachingItemData;
      return () {};
    }, []);

    // 選択中の教材データ
    final registerHomeworkData = useState<List<RegisterHomework>>([]); // 空で初期化
    // indexを受け取って配列に追加
    void register(int index) {
      final newHomework = RegisterHomework(teachingItem: teachingMaterialData.value[index]); // 追加したいオブジェクト
      registerHomeworkData.value = List.from(registerHomeworkData.value)..add(newHomework); // 追加
    }

    return BasicTemplate(
        title: title,
        // 下書き一覧に遷移
        featureIconButton: IconButton(onPressed: () {}, icon: featureIconButton),
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
            registerHomeworkData: registerHomeworkData.value,
          )),

          // ボタン
          Row(
              mainAxisAlignment: MainAxisAlignment.center, // 真ん中寄せ
              children: [
                BasicButton(
                  width: 0.37,
                  text: '下書きに保存',
                  onPressed: () {
                     // TODO:APIに登録処理
                  },
                  isColor: true,
                ),
                const SizedBox(width: 60),
                BasicButton(
                  icon: Icons.check,
                  text: '登録',
                  width: 0.37,
                  onPressed: () {

                    // TODO:APIに登録処理

                  },
                  isColor: false,
                ),
              ])
        ]);
  }
}
