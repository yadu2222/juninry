import 'package:flutter/material.dart';
import '../../components/template/basic_template.dart';
import '../../components/atoms/info_form.dart';
import '../../components/atoms/basic_button.dart';
import '../../../apis/controller/user_req.dart';
import '../../../models/user_model.dart';

class PageLogin extends StatelessWidget {
  PageLogin({super.key});

  final String title = 'ログイン';
  final TextEditingController mailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  // userオブジェクトを生成？
  void login() async {
    final User user = User(userUUID: '', userName: '', userTypeId: 0, mailAddress: mailController.text, password: passController.text, jtiUUID: '', jwtKey: '');
    await UserReq.login(user);
  }

  @override
  Widget build(BuildContext context) {
    return BasicTemplate(title: title, popIcon: false, children: [
      const SizedBox(height: 50),
      InfoForm(label: 'メールアドレス', controller: mailController),
      InfoForm(label: 'パスワード', controller: passController),
      const SizedBox(height: 20),
      BasicButton(
        width: 0.4,
        text: 'ログイン',
        isColor: true,
        onPressed: () async => {},
        circular: 50,
      ),
    ]);
  }
}
