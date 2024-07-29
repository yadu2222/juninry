import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
// view
import '../../components/template/basic_template.dart';
import '../../components/atoms/info_form.dart';
import '../../components/atoms/toast.dart';
import '../../components/atoms/basic_button.dart';
import '../../components/molecule/drop_down.dart';
// api
import '../../../apis/controller/user_req.dart'; // リクエスト
// 定数
import '../../../constant/colors.dart';
import '../../../constant/Fonts.dart';
import '../../../constant/messages.dart';

class PageUserRegister extends HookWidget {
  PageUserRegister({super.key, required this.updRouter});

    final void Function() updRouter;
  final String title = '新規登録';
  final TextEditingController mailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    UserReq userReq = UserReq(context: context); // UserReqクラスのインスタンスを生成
    // userType選択
    final userType = useState<int?>(null); // 1 teacher or 2 junior or 3 patron
    final userGender = useState<int?>(null); // 1 otoko or 2 onnna or 3 other
    // 値変更
    void onUserType(int? i) {
      // タイプ
      userType.value = i;
    }

    void onGenderType(int? i) {
      // 性別
      userGender.value = i;
    }

    // dropdownに渡すリスト
    final List<Map<String, dynamic>> userTypeItem = [
      // userType
      {'display': '児童', 'value': 2},
      {'display': '保護者', 'value': 3},
      {'display': '教員', 'value': 1},
    ];
    final List<Map<String, dynamic>> userGenderItem = [
      // userGender
      {'display': '男', 'value': 1},
      {'display': '女', 'value': 2},
      {'display': '未回答', 'value': 3},
    ];

    // 登録処理
    void register() async {
      // 入力が不足していれば弾く
      if (nameController.text.isNotEmpty && mailController.text.isNotEmpty && passController.text.isNotEmpty && userType.value != null && userGender.value != null) {
        // ボタンを押したときにTextEditingControllerの値を取得
        Map<String, dynamic> userData = {
          "userName": nameController.text,
          "userTypeId": userType.value!,
          "mailAddress": mailController.text,
          "password": passController.text,
          "genderId": userType.value!
        };
        await userReq.registerUserHandler(userData, updRouter); // なげる
      } else {
        ToastUtil.show(message: Messages.inputError);
      }
    }

    return Scaffold(
        backgroundColor: AppColors.main, // 背景色設定
        body: BasicTemplate(title: title, popIcon: false, children: [
          const SizedBox(height: 50),
          InfoForm(label: 'お名前', controller: nameController, inputType: TextInputType.text),
          InfoForm(label: 'メールアドレス', controller: mailController, inputType: TextInputType.emailAddress),
          InfoForm(label: 'パスワード', controller: passController, inputType: TextInputType.visiblePassword),
          // userType選択
          DropDownUtil(
            items: userTypeItem,
            onChanged: onUserType,
            value: userType.value,
            hint: 'あなたの役割を選択してください',
          ),
          // 性別選択
          DropDownUtil(
            items: userGenderItem,
            onChanged: onGenderType,
            value: userGender.value,
            hint: '性別を選択してください',
          ),
          const SizedBox(height: 40),
          BasicButton(
            width: 0.4,
            text: '新規登録',
            isColor: true,
            onPressed: () {
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
