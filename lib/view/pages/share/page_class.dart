import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/services.dart';
import '../../../router/router.dart';
// view
import '../../components/atoms/toast.dart';
import '../../components/template/basic_template.dart';
import '../../components/atoms/info_form.dart';
import '../../components/atoms/basic_button.dart';
import '../../components/molecule/invite_dialog.dart';
import '../../components/molecule/divider.dart';
import '../../components/organism/join_list.dart';
import '../../components/atoms/alert_dialog.dart';
// api
import '../../../apis/controller/class_req.dart'; // リクエスト
// model
import '../../../models/class_model.dart';
// 定数
import '../../../constant/messages.dart';

class PageClass extends HookWidget {
  PageClass({super.key});

  final String title = 'クラス';
  final TextEditingController classNameController = TextEditingController();
  final TextEditingController inviteCodeController = TextEditingController();
  final TextEditingController studentNumController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ClassReq classReq = ClassReq(context: context); // ClassReqクラスのインスタンスを生成
    final isTeacher = useState<bool>(false); // 教員か判別
    final joinClasses = useState<List<Class>>([]); // データを格納するための変数
    final conType = useState<bool>(true); // true:join,false:create

    // クラス一覧取得
    Future<void> getClasses() async {
      // TODO:APIからクラス一覧を取得
      classReq.getClassesHandler().then((value) => joinClasses.value = value);
    }

    // クラス作成
    void create() async {
      if (classNameController.text.isNotEmpty) {
        Map<String, dynamic> resData = await classReq.createClassHandler(classNameController.text);
        if (resData['isCreate']) {
          inviteDialog(context: context, classData: resData['classData']); // 作成成功ダイアログ

          classNameController.clear(); // 入力値クリア
          getClasses(); // クラスを再取得
        }
      } else {
        ToastUtil.show(message: Messages.inputError); // 入力不足エラー
      }
    }

    // 現在のtypeを切り替える(create or join)
    void changeConType() {
      conType.value = !conType.value;
    }

    // クラスに参加
    void join() async {
      FocusScope.of(context).unfocus(); // キーボードを閉じる
      if (inviteCodeController.text.isNotEmpty) {
        String? className = await classReq.joinClassHandler(inviteCodeController.text, studentNumController.text);
        if (className != null) {
          AlertDialogUtil.show(
            context: context,
            content: '$className${Messages.joinClassSuccess}',
            positiveAction: ('OK', () {}),
          );
        }
        getClasses(); // クラスを再取得
        inviteCodeController.clear(); // 入力値クリア
        // TODO:getClass
      } else {
        ToastUtil.show(message: Messages.inputError);
      }
    }

    // 教員の場合のみ表示
    List<Map> tabs = [
      {
        'title': 'クラスに参加しましょう',
        'button': '参加する',
        'label': '招待コード',
        'controller': inviteCodeController,
        'api': join,
        'inputType': TextInputType.number,
        'inputFormat': [FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(4),
        ]
      },
      {
        'title': '新しいクラスを作成しましょう',
        'button': '作成する',
        'label': '新しいクラス名',
        'controller': classNameController,
        'api': create,
        'inputType': TextInputType.text,
        'inputFormat': [LengthLimitingTextInputFormatter(15)]
      },
    ];

    final conTypeMap = useState<Map>(tabs[0]); // true:invite,false:create
    // 参加と作成を切り替えて返す
    void getTab() {
      if (conType.value) {
        conTypeMap.value = tabs[0];
      } else {
        conTypeMap.value = tabs[1];
      }
    }

    // 招待コード再発行
    void invite(Class classData) async {
      Map<String, dynamic> resData = await classReq.inviteClassHandler(classData.classUUID!);
      if (resData['isCreate']) {
        inviteDialog(context: context, classData: resData['classData']); // 作成成功ダイアログ
        // 成功したということは参加クラスが増えたということなので、クラスも再取得
        await getClasses();
      } else {
        ToastUtil.show(message: Messages.inviteClassError); // 招待コード発行エラー
      }
    }

    // 初回実行時に呼び出し
    useEffect(() {
      isBranch(BranchType.teacher).then((value) => isTeacher.value = value); // 教員かどうか
      getClasses(); // クラス一覧を取得
      getTab(); // create or join
      return () {};
    }, [conType.value]);

    return BasicTemplate(title: title, children: [
      const SizedBox(height: 30),
      Text(conTypeMap.value['title']), // 説明文
      // 入力フォーム
      InfoForm(
        label: conTypeMap.value['label'],
        controller: conTypeMap.value['controller'],
        icon: Icons.autorenew,
        isIcon: isTeacher.value,
        onTap: changeConType, // type切り替え
        inputType: conTypeMap.value['inputType'],
        inputFormatter: conTypeMap.value['inputFormat'],
      ),

      isTeacher.value
          ? const SizedBox.shrink()
          : InfoForm(
              label: '出席番号(なければ空欄)',
              controller: studentNumController,
              inputType: TextInputType.number,
              inputFormatter: [FilteringTextInputFormatter.digitsOnly],
            ),
      const SizedBox(height: 20),
      // 確定
      BasicButton(
        width: 0.4,
        text: conTypeMap.value['button'],
        isColor: false,
        onPressed: conTypeMap.value['api'],
        circular: 50,
      ),

      joinClasses.value.isEmpty
          ? const SizedBox.shrink()
          : const DividerView(
              icon: Icons.door_back_door,
              title: '参加中のクラス',
            ),
      // 現在参加中のクラス一覧
      Expanded(
        child: JoinList(
          isTeacher: isTeacher.value,
          joinClasses: joinClasses.value,
          invite: invite,
        ),
      )
    ]);
  }
}
