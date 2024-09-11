import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';

// view
import '../../components/template/basic_template.dart';
import '../../components/atoms/toast.dart';
import '../../components/atoms/alert_dialog.dart';
import '../../components/organism/homework_register_tab.dart';
import '../../components/molecule/divider.dart';
import '../../components/organism/register_homework_list.dart';
import '../../components/atoms/basic_button.dart';
import 'package:juninry/view/components/organism/homework_note_tab.dart';

// model
import '../../../models/register_homework_model.dart';
import '../../../models/class_model.dart';
import '../../../models/teaching_item_model.dart';
// api
import '../../../apis/controller/class_req.dart';
import '../../../apis/controller/homework_req.dart';
// constant
import '../../../constant/messages.dart';

// sample
import 'package:juninry/constant/sample_data.dart';

class PageHomeworkRegisterTeacher extends HookWidget {
  // タイトル
  final String title = '課題登録';
  // 右上に表示するアイコン
  final Icon featureIconButton = const Icon(
    Icons.drive_file_rename_outline_rounded,
    size: 30,
  );
  const PageHomeworkRegisterTeacher({super.key, this.selectedDate});
  final String? selectedDate; // routeがエラーを吐くのでStringで受け取る

  @override
  Widget build(BuildContext context) {
    ClassReq classReq = ClassReq(context: context); // ClassReqクラスのインスタンスを生成
    HomeworkReq homeworkReq = HomeworkReq(context: context); // HomeworkReqクラスのインスタンスを生成
    // 教材リスト
    final teachingMaterialData = useState<List<TeachingItem>>([]); // 表示する教材のリスト
    // 課題データ
    final selectDateOld = useState<String?>(selectedDate); // dbから取得する日付データ格納 stringじゃないと下書きページから渡されるときにエラーを吐く？様子
    final selectDate = useState<DateTime>(DateTime.now().add(const Duration(days: 1))); // 登録する日付
    final registerHomeworkData = useState<List<RegisterHomework>>([]); // 空で初期化 現在選択中の課題データを格納
    final registerHomeworkDataOld = useState<List<RegisterHomework>>([]); // 空で初期化 dbから読み込んだ課題データを格納
    // クラスのデータ
    final classList = useState<List<Class>>([]); // 空で初期化  // apiから取得
    final selectClass = useState<Class>(Class(className: 'からっぽだね')); // nullで初期化 選択中のクラス

    Future<void> getTeachingItem() async {
      homeworkReq.getTeachingItemsHandler(selectClass.value.classUUID!).then((value) {
        teachingMaterialData.value = value;
      });
    }

    // indexを受け取って配列に追加
    void add(int index) {
      final newHomework = RegisterHomework(homeworkLimit: selectDate.value, classUUID: selectClass.value.classUUID!, teachingItem: teachingMaterialData.value[index]); // 追加したいオブジェクト
      registerHomeworkData.value = List.from(registerHomeworkData.value)..add(newHomework); // 追加
    }

    // indexを受け取って配列から削除
    // あくまで表示上の削除であり、下書きに保存のタイミングで変更をかける
    void deleteRgisterHomework(int index) {
      // RegisterHomework.deleteHomeworkDrafts(registerHomeworkData.value[index]); // dbから削除
      registerHomeworkData.value = List.from(registerHomeworkData.value)..removeAt(index); // 削除
    }

    // クラス一覧を取得
    Future<void> getClasses() async {
      classList.value = await classReq.getClassesHandler();
      selectClass.value = classList.value[0]; // 初期値
    }

    // // 日付を選択
    Future<void> selectDatePicker() async {
      DateTime tomorrow = DateTime.now().add(const Duration(days: 1));

      DatePicker.showDatePicker(context, showTitleActions: true, minTime: tomorrow, maxTime: DateTime(2030, 12, 31), onChanged: (date) {
        selectDate.value = date;
      }, currentTime: tomorrow, locale: LocaleType.jp);
    }

    // db保存処理
    Future<bool> save() async {
      // 元の配列と現在の配列を比較して変更があればDBに投げる
      // 古いものを全削除
      for (var homework in registerHomeworkDataOld.value) {
        RegisterHomework.deleteHomeworkDrafts(homework);
      }
      // 日付とクラスを更新
      for (var homework in registerHomeworkData.value) {
        homework.classUUID = selectClass.value.classUUID!;
        homework.homeworkLimit = selectDate.value;
      }
      bool isRegister = await RegisterHomework.registerHomeworkDrafts(registerHomeworkData.value);
      return isRegister;
    }

    // 下書き保存
    Future<void> draftSave() async {
      if (await save()) {
        ToastUtil.show(message: Messages.draftRegisterSuccess);
        context.go('/homework');
      } else {
        ToastUtil.show(message: Messages.databaseErrorMsg);
      }
    }

    // 変更がある場合の処理
    bool oldCheck() {
      if (registerHomeworkData.value.isNotEmpty && registerHomeworkDataOld.value != registerHomeworkData.value || selectDateOld.value != selectDate.value.toString()) {
        // 変更がある場合
        // 保存を促す
        AlertDialogUtil.show(
          context: context,
          content: Messages.confirmationMsg,
          negativeAction: (
            "無視する",
            () {
              context.go('/homework');
            }
          ),
          positiveAction: (
            "保存する",
            () async {
              draftSave();
            }
          ),
        );
        return false;
      } else {
        context.go('/homework');
        return false;
      }
    }

    //クラス選択時の処理
    void onClassChanged(Class value) {
      // 配列を初期化
      registerHomeworkData.value = [];
      registerHomeworkDataOld.value = [];
      // 選択中のクラスを更新
      selectClass.value = value;
      // 教材データを再取得
      getTeachingItem();
    }

    // 宿題登録
    Future<void> registerHomework() async {
      try {
        // 日付とクラスを更新
        for (var homework in registerHomeworkData.value) {
          homework.classUUID = selectClass.value.classUUID!;
          homework.homeworkLimit = selectDate.value;
        }
        await homeworkReq.registerHomeworkHandler(registerHomeworkData.value); // 課題登録を待つ
        ToastUtil.show(message: Messages.registerSuccess);
        GoRouter.of(context).go('/homework'); // 画面遷移
      } catch (e) {
        print(e);
        ToastUtil.show(message: Messages.registerError);
      }
    }

    // 初回のみ実行
    // ここでapiから教材リストを取得
    useEffect(() {
      Future<void> fetchData() async {
        await getClasses(); // クラス一覧を取得
        getTeachingItem();

        // 下書きを呼び出している場合
        if (selectedDate != null) {
          final data = await RegisterHomework.getHomeworkDraftsForDate(DateTime.parse(selectDateOld.value!));
          debugPrint(data.toString());
          registerHomeworkDataOld.value = data;
          registerHomeworkData.value = data;
          selectDate.value = DateTime.parse(selectDateOld.value!);
        } else {
          // 引数が空のときは変数に格納する日付をあわせる
          selectDate.value = DateTime.now().add(const Duration(days: 1));
          selectDateOld.value = selectDate.value.toString();
        }
      }

      fetchData();
      teachingMaterialData.value = SampleData.teachingItemData;
      return () {};
    }, []);

    return BasicTemplate(
        title: title,
        popIcon: true,
        // 変更があれば保存を促す
        popFunction: oldCheck,
        // 下書き一覧に遷移
        featureIconButton: IconButton(
            onPressed: () {
              GoRouter.of(context).go('/homework/register/drafts');
            },
            icon: featureIconButton),
        children: [
          HomeworkNoteTab(
            selectDate: selectDatePicker,
            date: selectDate.value.toString(),
            selectClass: selectClass.value,
            classList: classList.value,
            onChanged: onClassChanged,
          ),

          HomeworkRegisterTab(
            teachingItemData: teachingMaterialData.value,
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
                  onPressed: draftSave,
                  isColor: true,
                ),
                const SizedBox(width: 60),
                BasicButton(
                  icon: Icons.check,
                  text: '登録',
                  width: 0.37,
                  onPressed: registerHomework,
                  isColor: false,
                ),
              ])
        ]);
  }
}
