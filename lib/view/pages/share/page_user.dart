import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../constant/fonts.dart';
import '../../../view/components/atoms/basic_button.dart';
import '../../../models/user_model.dart';
import '../../components/template/basic_template.dart';

class PageUserData extends StatelessWidget {
  const PageUserData({
    super.key,
  });

  final String title = 'ユーザー';

  @override
  Widget build(BuildContext context) {
    void logout() async {
      // ログアウト処理
      bool isLogout = await User.logout(); // dbからデータを削除
      if (isLogout) {
        // ログイン画面に遷移
        context.go('/login');
      } else {}
    }

    return BasicTemplate(title: title, children: [
      const Text('ユーザー情報', style: Fonts.h3),
      BasicButton(
        text: 'ログアウト',
        isColor: false,
        onPressed: () {
          logout();
        },
      ),
      BasicButton(
        text: 'マイページ',
        isColor: true,
        onPressed: () {
          context.go('/userData/myPage');
        },
      ),
    ]);
  }
}
