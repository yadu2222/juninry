import 'package:flutter/material.dart';
import '../../components/template/basic_template.dart';
import '../../components/atoms/info_form.dart';
import '../../components/atoms/basic_button.dart';
import '../../../apis/controller/user_req.dart';

import '../../../constant/colors.dart';
import '../../../constant/Fonts.dart';
import 'package:go_router/go_router.dart';

class PageUserRegister extends StatelessWidget {
  PageUserRegister({super.key});

  final String title = '新規登録';
  final TextEditingController mailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    UserReq userReq = UserReq(context: context);

    return Scaffold(
        backgroundColor: AppColors.main, // 背景色設定

        body: BasicTemplate(title: title, popIcon: false, children: [
          const SizedBox(height: 50),
          InfoForm(label: 'お名前', controller: nameController),
          InfoForm(label: 'メールアドレス', controller: mailController),
          InfoForm(label: 'パスワード', controller: passController),
          // TODO:ここでユーザーの種類を選択するようにする
          const SizedBox(height: 40),
          BasicButton(
            width: 0.4,
            text: '新規作成',
            isColor: true,
            onPressed: () async {
              // ボタンを押したときにTextEditingControllerの値を取得
              Map<String, dynamic> userData = {
                "userName": nameController.text,
                "userTypeId": 1,
                "mailAddress": mailController.text,
                "password": passController.text,
              };
              await userReq.registerUser(userData);
            },
            circular: 50,
          ),
          InkWell(
            onTap: () => {context.go('/login')},
            child: const Text('ログインはこちら', style: Fonts.h5w),
          )
        ]));
  }
}
