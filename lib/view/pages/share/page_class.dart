import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../../../router/router.dart';
// view
import '../../components/atoms/toast.dart';
import '../../components/template/basic_template.dart';
import '../../components/atoms/info_form.dart';
import '../../components/atoms/basic_button.dart';
import '../../components/molecule/invite_dialog.dart';
import '../../components/molecule/divider.dart';
import '../../components/organism/join_list.dart';
// api
import '../../../apis/controller/class_req.dart'; // リクエスト
// model
import '../../../models/class_model.dart';
// 定数
import '../../../constant/messages.dart';
// sample
import '../../../constant/sample_data.dart';

class PageClass extends HookWidget {
  PageClass({super.key});

  final String title = 'クラス';
  final TextEditingController classNameController = TextEditingController();
  final TextEditingController inviteCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ClassReq classReq = ClassReq(context: context); // ClassReqクラスのインスタンスを生成
    final isTeacher = useState<bool>(false); // 教員か判別
    final joinClasses = useState<List<Class>>(SampleData.classList); // データを格納するための変数
    final conType = useState<bool>(true); // true:join,false:create

    // クラス作成
    void create() async {
      if (classNameController.text.isNotEmpty) {
        Map<String, dynamic> resData = await classReq.createClassHandler(classNameController.text);
        if (resData['isCreate']) {
          inviteDialog(context, resData['classData']); // 作成成功ダイアログ
          classNameController.clear(); // 入力値クリア
        }
      } else {
        ToastUtil.show(message: Messages.inputError); // 入力不足エラー
      }
    }

    // クラスに参加
    void join() async {
      if (inviteCodeController.text.isNotEmpty) {
        await classReq.joinClassHandler(inviteCodeController.text);
        inviteCodeController.clear(); // 入力値クリア
      } else {
        ToastUtil.show(message: Messages.inputError);
      }
    }

    // 教員の場合のみ表示
    List<Map> tabs = [
      {'title': 'クラスに参加しましょう', 'button': '参加する', 'label': '招待コード', 'controller': inviteCodeController, 'api': join},
      {'title': '新しいクラスを作成しましょう', 'button': '作成する', 'label': '新しいクラス名', 'controller': classNameController, 'api': create},
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

    // クラス一覧取得
    Future<void> getClasses() async {
      // TODO:APIからクラス一覧を取得
    }
    // 現在のtypeを切り替える(create or join)
    void changeConType() {
      conType.value = !conType.value;
    }

    // 招待コード再発行
    void invite(Class classData) async {
      Map<String, dynamic> resData = await classReq.inviteClassHandler(classData.classUUID!);
      if (resData['isCreate']) {
        inviteDialog(context, resData['classData']); // 作成成功ダイアログ
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
      const DividerView(
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
