import 'package:flutter/material.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
// view
import '../../components/atoms/toast.dart';
import '../../components/template/basic_template.dart';
import '../../components/atoms/info_form.dart';
import '../../components/atoms/basic_button.dart';
import '../../../apis/controller/class_req.dart'; // リクエスト
// 定数
import '../../../constant/messages.dart';
import '../../../constant/fonts.dart';

class PageJoinClass extends StatelessWidget {
  PageJoinClass({super.key});

  final String title = 'クラスに参加';
  final TextEditingController inviteCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ClassReq classReq = ClassReq(context: context); // ClassReqクラスのインスタンスを生成
    // 参加処理
    void join() async {
      if (inviteCodeController.text.isNotEmpty) {
        await classReq.joinClassHandler(inviteCodeController.text);
        // await userReq.loginHandler(User(userUUID: "", userName: "", userTypeId: 0, mailAddress: mailController.text, password: passController.text, jtiUUID: "", jwtKey: ""), updRouter);
      } else {
        ToastUtil.show(message: Messages.inputError);
      }
    }

    return BasicTemplate(title: title, children: [
      const SizedBox(height: 50),
      InfoForm(label: '招待コード', controller: inviteCodeController),
      const SizedBox(height: 20),
      BasicButton(
        width: 0.4,
        text: '参加する',
        isColor: true,
        onPressed: () {
          join();
        },
        circular: 50,
      ),
      InkWell(
        onTap: () => {context.go('/home/create')},
        child: const Text('クラス作成はこちら', style: Fonts.pw),
      )
    ]);
  }
}
