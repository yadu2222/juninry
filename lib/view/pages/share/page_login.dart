import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../models/user_model.dart';

import '../../components/atoms/toast.dart';
import '../../components/template/basic_template.dart';
import '../../components/atoms/info_form.dart';
import '../../components/atoms/basic_button.dart';
import '../../../apis/controller/user_req.dart'; // リクエスト

// 定数
import '../../../constant/colors.dart';
import '../../../constant/Fonts.dart';
import '../../../constant/messages.dart';

class PageLogin extends StatelessWidget {
  PageLogin({super.key});

  final String title = 'ログイン';
  final TextEditingController mailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    UserReq userReq = UserReq(context: context);

    // ログイン処理
    void login() async {
      if (mailController.text.isNotEmpty && passController.text.isNotEmpty) {
        await userReq.login(User(userUUID: "", userName: "", userTypeId: 0, mailAddress: mailController.text, password: passController.text, jtiUUID: "", jwtKey: ""));
      } else {
        ToastUtil.show(message: Messages.inputError);
      }
    }

    return Scaffold(
        backgroundColor: AppColors.main, // 背景色設定

        body: BasicTemplate(title: title, popIcon: false, children: [
          const SizedBox(height: 50),
          InfoForm(label: 'メールアドレス', controller: mailController),
          InfoForm(label: 'パスワード', controller: passController),
          const SizedBox(height: 40),
          BasicButton(
            width: 0.4,
            text: 'ログイン',
            isColor: true,
            onPressed: () {
              login();
            },
            circular: 50,
          ),
          InkWell(
            onTap: () => {context.go('/register')},
            child: const Text('新規登録はこちら', style: Fonts.h5w),
          )
        ]));
  }
}
