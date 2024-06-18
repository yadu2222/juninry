import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:juninry/constant/sample_data.dart';
import 'package:juninry/view/components/atoms/teaching_material.dart';
import '../../components/template/scroll_template.dart';
// import '../../components/organism/homework_register_form.dart';
import '../../components/organism/homework_register_tab.dart';
import '../../../models/teaching_item_model.dart';
import '../../components/molecule/divider.dart';


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
     late List<TeachingItem> teachingMaterialData;
    

    // 初回のみ実行
    // ここでapiから教材リストを取得
    useEffect(() {
      teachingMaterialData = SampleData.teachingItemData;
      return () {};
    }, []);

    // 選択中の教材データ
    final registerHomework = useState<List<RegisterHomework>>([]); // 空で初期化
    // indexを受け取って登録処理
    void register(int index) {
      // ここで登録処理を追加
      registerHomework.value.add(RegisterHomework(teachingItem: teachingMaterialData[index]));
    }

    return ScrollTemplate(
        title: title,
        // 下書き一覧に遷移
        featureIconButton: IconButton(onPressed: () {}, icon: featureIconButton),
        children: [
          // ここに課題登録フォームを追加
          HomeworkRegisterTab(
            teachingItemData: teachingMaterialData,
            onTap: () {},
          ),
          // 区切り線
          const DividerView(
            indent: 15,
            endIndent: 15,
            dividWeight: 2,
          )
        ]);
  }
}

class RegisterHomework {
  TeachingItem teachingItem;
  int? startPage;
  int? pageCount;

  RegisterHomework({
    required this.teachingItem,
    this.startPage,
    this.pageCount,
  });
}
