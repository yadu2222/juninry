import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/services.dart';
// view
import '../../components/atoms/toast.dart';
import '../../components/template/basic_template.dart';
import '../../components/atoms/info_form.dart';
import '../../components/atoms/basic_button.dart';
// import '../../components/atoms/alert_dialog.dart';
import '../../components/atoms/dialog.dart';
// api
import 'package:juninry/apis/controller/user_req.dart';
// 定数
import '../../../constant/messages.dart';

class PageJoinOuchi extends HookWidget {
  PageJoinOuchi({super.key});

  final String title = 'おうち';
  final TextEditingController inviteCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    UserReq userReq = UserReq(context: context); // ClassReqクラスのインスタンスを生成

    // おうちに参加
    void join() async {
      if (inviteCodeController.text.isNotEmpty) {
        String? ouchiName = await userReq.joinOUCHIHandler(inviteCodeController.text);
        if (ouchiName != null) {
          // 参加成功ダイアログ
          // TODO:デザイン
          DialogUtil.show(
              context: context,
              child: SizedBox(
                child: Column(children: [Text('$ouchiName${Messages.joinClassSuccess}')]),
              ));
        }
        inviteCodeController.clear(); // 入力値クリア
        context.go('/ouchi/top');
      } else {
        ToastUtil.show(message: Messages.inputError);
      }
    }

    return BasicTemplate(title: title, children: [
      const SizedBox(height: 30),
      const Text('おうちに参加しましょう'), // 説明文
      // 入力フォーム
      InfoForm(
        label: '招待コード',
        controller: inviteCodeController,
        icon: Icons.autorenew,
        inputType: TextInputType.number,
        inputFormatter: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(6)],
      ),
      const SizedBox(height: 20),
      // 確定
      BasicButton(
        width: 0.4,
        text: '参加する',
        isColor: false,
        onPressed: join,
        circular: 50,
      ),
    ]);
  }
}
