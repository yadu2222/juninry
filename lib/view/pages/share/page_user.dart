import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../constant/fonts.dart';
import '../../../view/components/atoms/basic_button.dart';

import '../../../router/router.dart';

import '../../../models/user_model.dart';
import '../../components/template/basic_template.dart';

class PageUserData extends StatelessWidget {
  const PageUserData({super.key,});

  final String title = 'ユーザー';

  @override
  Widget build(BuildContext context) {
    void logout() async {
      // ログアウト処理
      bool isLogout = await User.logout();
      if (isLogout) {
        // ルーターの再取得
        final newRouter = await createRouter();
        context.go('');
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
    ]);
  }
}
