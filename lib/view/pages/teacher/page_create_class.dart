import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
// view
import '../../components/atoms/toast.dart';
import '../../components/template/basic_template.dart';
import '../../components/atoms/info_form.dart';
import '../../components/atoms/basic_button.dart';
import '../../components/molecule/invite_dialog.dart';
import '../../components/organism/class_con_tab.dart';
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

class PageCreateClass extends HookWidget {
  PageCreateClass({super.key});

  final String title = 'クラスを作成';
  final TextEditingController classNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final joinClasses = useState<List<Class>>(SampleData.classList); // データを格納するための変数

    ClassReq classReq = ClassReq(context: context); // ClassReqクラスのインスタンスを生成
    // 作成処理
    void join() async {
      if (classNameController.text.isNotEmpty) {
        Map<String, dynamic> resData = await classReq.createClassHandler(classNameController.text);
        if (resData['isCreate']) {
          inviteDialog(context, resData['class']); // 作成成功ダイアログ
          classNameController.clear(); // 入力値クリア
        }
      } else {
        ToastUtil.show(message: Messages.inputError); // 入力不足エラー
      }
    }

    // クラス一覧取得
    Future<void> getClasses() async {
      // TODO:APIからクラス一覧を取得
      // joinClasses.value = await classReq.getClassesHandler();
    }

    // 招待コード再発行
    void invite(Class classData) async {
      Map<String, dynamic> resData = await classReq.inviteClassHandler(classData.classUUID!);
      if (resData['isCreate']) {
        inviteDialog(context, resData['class']); // 作成成功ダイアログ
        // 成功したということは参加クラスが増えたということなので、クラスも再取得
        await getClasses();
      } else {
        ToastUtil.show(message: Messages.inviteClassError); // 招待コード発行エラー
      }
    }

    // 初回実行時に呼び出し
    useEffect(() {
      getClasses();

      return () {};
    }, []);

    return BasicTemplate(title: title, children: [
      const SizedBox(height: 30),
      const ClassConTab(), // 操作タブ
      InfoForm(
        label: '新しいクラス名',
        controller: classNameController,
        // isSearch: true,
        // search: join,
      ),
      const SizedBox(height: 20),
      BasicButton(
        width: 0.4,
        text: '作成する',
        isColor: true,
        onPressed: () {
          join();
        },
        circular: 50,
      ),
      const DividerView(
        icon: Icons.door_back_door,
        title: '参加中のクラス',
      ),
      // 現在参加中のクラス一覧
      Expanded(
        child: JoinList(
          joinClasses: joinClasses.value,
          invite: invite,
        ),
      )
    ]);
  }
}
