import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:juninry/apis/controller/ouchi_req.dart';
// view
import '../../components/atoms/toast.dart';
import '../../components/template/basic_template.dart';
import '../../components/atoms/info_form.dart';
import '../../components/atoms/basic_button.dart';
import '../../components/atoms/alert_dialog.dart';
// 定数
import '../../../constant/messages.dart';

class PageCreateOuchi extends HookWidget {
  PageCreateOuchi({super.key});

  final String title = 'おうち';
  final TextEditingController ouchiNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    OUCHIReq ouchiReq = OUCHIReq(context); // ClassReqクラスのインスタンスを生成

    // おうちを作成
    void join() async {
      if (ouchiNameController.text.isNotEmpty) {
        String? ouchiName = await ouchiReq.createOuchiHandler(ouchiNameController.text);
        if (ouchiName != null) {
          // 参加成功ダイアログ
          AlertDialogUtil.show(
            context: context,
            content: '$ouchiName${Messages.createClassSuccess}',
            positiveAction: ('OK', () {}),
          );
        }
        ouchiNameController.clear(); // 入力値クリア
      } else {
        ToastUtil.show(message: Messages.inputError);
      }
    }

    return BasicTemplate(title: title, children: [
      const SizedBox(height: 30),
      const Text('おうちをつくりましょう'), // 説明文
      // 入力フォーム
      InfoForm(
        label: 'おうちのなまえ',
        controller: ouchiNameController,
        icon: Icons.autorenew,
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
