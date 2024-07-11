import 'package:flutter/material.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
// view
import '../../components/atoms/toast.dart';
import '../../components/template/basic_template.dart';
import '../../components/atoms/info_form.dart';
import '../../components/atoms/basic_button.dart';
import '../../components/molecule/invite_dialog.dart';
// api
import '../../../apis/controller/class_req.dart'; // リクエスト
// 定数
import '../../../constant/messages.dart';
import '../../../constant/fonts.dart';

class PageCreateClass extends StatelessWidget {
  PageCreateClass({super.key});

  final String title = 'クラスを作成';
  final TextEditingController classNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ClassReq classReq = ClassReq(context: context); // ClassReqクラスのインスタンスを生成
    // 作成処理
    void join() async {
      if (classNameController.text.isNotEmpty) {
        Map<String,dynamic> resData = await classReq.createClassHandler(classNameController.text);
        if (resData['isCreate']) {
          inviteDialog(context, resData);     // 作成成功ダイアログ
          classNameController.clear();
        }
      } else {
        ToastUtil.show(message: Messages.inputError); // 入力不足エラー
      }
    }

    return BasicTemplate(title: title, children: [
      const SizedBox(height: 50),
      InfoForm(label: 'クラス名', controller: classNameController),
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
      InkWell(
        onTap: () => {context.go('/home/join')},
        child: const Text('参加はこちら', style: Fonts.pw),
      )
    ]);
  }
}
