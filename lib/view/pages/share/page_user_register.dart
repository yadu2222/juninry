import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

import '../../components/template/basic_template.dart';
import '../../components/atoms/info_form.dart';
import '../../components/atoms/toast.dart';
import '../../components/atoms/basic_button.dart';
import '../../../apis/controller/user_req.dart'; // リクエスト

// 定数
import '../../../constant/colors.dart';
import '../../../constant/Fonts.dart';
import '../../../constant/messages.dart';

class PageUserRegister extends HookWidget {
  PageUserRegister({super.key});

  final String title = '新規登録';
  final TextEditingController mailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final userType = useState<int?>(1); // 1 or 2 or 3
    void _onPressed(int i) {
      userType.value = i;
    }

    UserReq userReq = UserReq(context: context); // UserReqクラスのインスタンスを生成

    // 登録処理
    void register() async {
      // 入力が不足していれば弾く
      if (nameController.text.isNotEmpty && mailController.text.isNotEmpty && passController.text.isNotEmpty && userType.value != null) {
        // ボタンを押したときにTextEditingControllerの値を取得
        Map<String, dynamic> userData = {
          "userName": nameController.text,
          "userTypeId": userType.value,
          "mailAddress": mailController.text,
          "password": passController.text,
        };
        await userReq.registerUser(userData); // なげる
      } else {
        ToastUtil.show(message: Messages.inputError);
      }
    }

    return Scaffold(
        backgroundColor: AppColors.main, // 背景色設定
        body: BasicTemplate(title: title, popIcon: false, children: [
          const SizedBox(height: 50),
          InfoForm(label: 'お名前', controller: nameController),
          InfoForm(label: 'メールアドレス', controller: mailController),
          InfoForm(label: 'パスワード', controller: passController),
          // TODO:ここでユーザーの種類を選択するようにする
          // TODO:性別選択
          const SizedBox(height: 40),
          BasicButton(
            width: 0.4,
            text: '新規登録',
            isColor: true,
            onPressed: ()  {
              register();
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
